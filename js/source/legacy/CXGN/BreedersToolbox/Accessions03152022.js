/*jslint browser: true, devel: true */
/**

=head1 Accessions.js

Dialogs for managing accessions


=head1 AUTHOR

Jeremy D. Edwards <jde22@cornell.edu>

=cut

*/

var $j = jQuery.noConflict();
var list = new CXGN.List();
var accessionList;
var accession_list_id;
var validSpecies;
var fuzzyResponse;
var fullParsedData;
var infoToAdd;
var accessionListFound;
var speciesNames;
var doFuzzySearch;

function disable_ui() {
    jQuery('#working_modal').modal("show");
}

function enable_ui() {
    jQuery('#working_modal').modal("hide");
}

jQuery(document).ready(function ($) {

    jQuery('#manage_accessions_populations_new').click(function(){
        jQuery("#create_population_list_div").html(list.listSelect("create_population_list_div", ["accessions"], undefined, undefined, undefined ));
        jQuery('#manage_populations_add_population_dialog').modal('show');
    });

    jQuery("#create_population_submit").click(function(){
        jQuery.ajax({
            type: 'POST',
            url: '/ajax/population/new',
            dataType: "json",
            data: {
                'population_name': jQuery('#create_population_name').val(),
                'accession_list_id': jQuery('#create_population_list_div_list_select').val(),
            },
            beforeSend: function(){
                disable_ui();
            },
            success: function (response) {
                enable_ui();
                if (response.error){
                    alert(response.error);
                }
                if (response.success){
                    alert(response.success);
                }
            },
            error: function (r) {
                alert('An error occurred in adding population. sorry '+r.responseText);
            }
        });
    });

    jQuery('#manage_accessions_populations_onswitch').click( function() {
      var already_loaded_tables = jQuery('#accordion').find("table");
      if (already_loaded_tables.length > 0) { return; }

      jQuery.ajax ( {
        url : '/ajax/manage_accessions/populations',
        beforeSend: function() {
          disable_ui();
        },
        success: function(response){
          var populations = response.populations;
          for (var i in populations) {
            var name = populations[i].name;
            var population_id = populations[i].stock_id;
            var accessions = populations[i].members;
            var table_id = name+i+"_pop_table";

            var section_html = '<div class="row"><div class="panel panel-default"><div class="panel-heading" >';
            section_html += '<div class="panel-title" name="populations_members_table_toggle" data-table_id="#'+table_id+'" data-population_id="'+population_id+'" data-population_name="'+name+'"><div class="row"><div class="col-sm-6" data-toggle="collapse" data-parent="#accordion" data-target="#collapse'+i+'"><a href="#'+table_id+'" class="accordion-toggle">'+name+'</a></div><div class="col-sm-3"><a href="/stock/'+population_id+'/view"><small>[Go To Population Page]</small></a></div><div class="col-sm-3"><a name="manage_populations_add_accessions" data-population_id="'+population_id+'" data-population_name="'+name+'"><small>[Add Accessions To Population]</small></a><br/><a name="manage_populations_delete_population" data-population_id="'+population_id+'" data-population_name="'+name+'"><small>[Delete Population]</small></a></div></div></div></div>';
            section_html += '<div id="collapse'+i+'" class="panel-collapse collapse">';
            section_html += '<div class="panel-body" style="overflow:hidden"><div class="table-responsive" style="margin-top: 10px;"><table id="'+table_id+'" class="table table-hover table-striped table-bordered" width="100%"></table><div id="populations_members_add_to_list_data_'+population_id+'" style="display:none"></div><br/><div id="populations_members_add_to_list_menu_'+population_id+'"></div></div>';
            section_html += '</div><br/></div></div></div><br/>';

            jQuery('#accordion').append(section_html);
          }
          enable_ui();
        },
        error: function(response) {
          enable_ui();
          alert('An error occured retrieving population data.');
        }
      });
    });

    jQuery(document).on("click", "div[name='populations_members_table_toggle']", function(){
        var table_id = jQuery(this).data('table_id');
        var population_id = jQuery(this).data('population_id');
        var population_name = jQuery(this).data('population_name');

        var table = jQuery(table_id).DataTable({
            ajax: '/ajax/manage_accessions/population_members/'+population_id,
            destroy: true,
            columns: [
                { title: "Accession Name", "data": null, "render": function ( data, type, row ) { return "<a href='/stock/"+row.stock_id+"/view'>"+row.name+"</a>"; } },
                { title: "Description", "data": "description" },
                { title: "Synonyms", "data": "synonyms[, ]" },
                { title: "Remove From Population", "data": null, "render": function ( data, type, row ) { return "<a name='populations_member_remove' data-stock_relationship_id='"+row.stock_relationship_id+"'>X</a>"; } },
            ],
            "fnInitComplete": function(oSettings, json) {
                //console.log(json);
                var html = "";
                for(var i=0; i<json.data.length; i++){
                    html += json.data[i].name+"\n";
                }
                jQuery("#populations_members_add_to_list_data_"+population_id).html(html);
                addToListMenu("populations_members_add_to_list_menu_"+population_id, "populations_members_add_to_list_data_"+population_id, {
                    selectText: true,
                    listType: 'accessions',
                    listName: population_name
                });
            }
        });

    });

    var population_id;
    var population_name;

    jQuery(document).on("click", "a[name='manage_populations_add_accessions']", function(){
        population_id = jQuery(this).data('population_id');
        population_name = jQuery(this).data('population_name');
        jQuery("#add_accession_to_population_list_div").html(list.listSelect("add_accession_to_population_list_div", ["accessions"], undefined, undefined, undefined));
        jQuery('#add_accession_population_name').html(population_name);
        jQuery('#manage_populations_add_accessions_dialog').modal('show');
    });

    jQuery(document).on("click", "a[name='manage_populations_delete_population']", function(){
        population_id = jQuery(this).data('population_id');
        population_name = jQuery(this).data('population_name');
        jQuery('#delete_population_name').html(population_name);
        jQuery('#manage_populations_delete_dialog').modal('show');
    });

    jQuery('#organization_name_input').autocomplete({
       source: '/ajax/stock/stockproperty_autocomplete?property=organization',
    });

    jQuery('#population_name_input').autocomplete({
       source: '/ajax/stock/population_autocomplete',
    });

    jQuery("#add_accessions_to_population_submit").click(function(){
        jQuery.ajax({
            type: 'POST',
            url: '/ajax/population/add_accessions',
            dataType: "json",
            data: {
                'population_name': population_name,
                'accession_list_id': jQuery('#add_accession_to_population_list_div_list_select').val(),
            },
            beforeSend: function(){
                disable_ui();
            },
            success: function (response) {
                enable_ui();
                if (response.error){
                    alert(response.error);
                }
                if (response.success){
                    alert(response.success);
                }
            },
            error: function () {
                alert('An error occurred in adding accessions to population. sorry');
            }
        });
    });

    jQuery("#delete_population_submit").click(function(){
        jQuery.ajax({
            type: 'POST',
            url: '/ajax/population/delete',
            dataType: "json",
            data: {
                'population_id': population_id,
                'population_name': population_name,
            },
            beforeSend: function(){
                disable_ui();
            },
            success: function (response) {
                enable_ui();
                if (response.error){
                    alert(response.error);
                }
                if (response.success){
                    alert(response.success);
                }
            },
            error: function () {
                alert('An error occurred in deleting population. sorry');
            }
        });
    });

    jQuery(document).on("click", "a[name='populations_member_remove']", function(){
        var stock_relationship_id= jQuery(this).data("stock_relationship_id");
        if (confirm("Are you sure?")){
            jQuery.ajax({
                url: '/ajax/population/remove_member?stock_relationship_id='+stock_relationship_id,
                dataType: "json",
                beforeSend: function(){
                    disable_ui();
                },
                success: function (response) {
                    enable_ui();
                    if (response.error){
                        alert(response.error);
                    }
                    if (response.success){
                        alert(response.success);
                    }
                },
                error: function () {
                    alert('An error occurred in removing accession from population. sorry');
                }
            });
        }
    });

    function add_accessions(full_info, species_names) {
        console.log(full_info);
        jQuery.ajax({
            type: 'POST',
            url: '/ajax/accession_list/add',
            dataType: "json",
            timeout: 36000000,
            data: {
                'full_info': JSON.stringify(full_info),
                'allowed_organisms': JSON.stringify(species_names),
            },
            beforeSend: function(){
                disable_ui();
            },
            success: function (response) {
                enable_ui();
		//alert("ADD ACCESSIONS: "+JSON.stringify(response));
                if (response.error) {
                    alert(response.error);
                } else {
                    var html = '\u5df2\u6210\u529f\u65b0\u589e\u4ee5\u4e0b\u7a2e\u539f (The following stocks were added)\uff1a<br/><br/>';
                    for (var i=0; i<response.added.length; i++){
                        html = html + '<a href="/stock/'+response.added[i][0]+'/view">'+response.added[i][1]+'</a><br/>';
                    }
                    jQuery('#add_accessions_saved_message').html(html);
                    jQuery('#add_accessions_saved_message_modal').modal('show');
                }
            },
            error: function (response) {
                alert('An error occurred in processing. sorry'+response.responseText);
            }
        });
    }

    function verify_species_name() {
        var speciesName = $("#species_name_input").val();
        validSpecies = 0;
        jQuery.ajax({
            type: 'GET',
            url: '/organism/verify_name',
            dataType: "json",
            data: {
                'species_name': speciesName,
            },
            success: function (response) {
                if (response.error) {
                    alert(response.error);
                    validSpecies = 0;
                } else {
                    validSpecies = 1;
                }
            },
            error: function (response) {
                alert('An error occurred verifying species name. sorry'+response.responseText);
                validSpecies = 0;
            }
        });
    }

    jQuery('#species_name_input').focusout(function () {
        verify_species_name();
    });

    jQuery('#review_absent_accessions_submit').click(function () {
        if (fullParsedData == undefined){
            var speciesName = jQuery("#species_name_input").val();
            var populationName = jQuery("#population_name_input").val();
            var organizationName = jQuery("#organization_name_input").val();
            var private_company_id = jQuery("#add_accessions_list_private_company_select").val();
            var accessionsToAdd = accessionList;
            if (!speciesName) {
                alert("Species name required");
                return;
            }
            if (!populationName) {
                populationName = '';
            }
            if (!accessionsToAdd || accessionsToAdd.length == 0) {
                alert("No accessions to add");
                return;
            }
            for(var i=0; i<accessionsToAdd.length; i++){
                infoToAdd.push({
                    'species':speciesName,
                    'defaultDisplayName':accessionsToAdd[i],
                    'germplasmName':accessionsToAdd[i],
                    'organizationName':organizationName,
                    'populationName':populationName,
                    'private_company_id':private_company_id
                });
                speciesNames.push(speciesName);
            }
        }
        add_accessions(infoToAdd, speciesNames);
        jQuery('#review_absent_dialog').modal("hide");
        //window.location.href='/breeders/accessions';
    });

    function verify_accessions_file() {
        var uploadFileInput = document.getElementById("new_accessions_upload_file");
        if (!uploadFileInput || !uploadFileInput.files || uploadFileInput.files.length === 0) {
            alert("Please select a file (\u8acb\u9078\u64c7\u6a94\u6848)");
            return;
        }

        var file = uploadFileInput.files[0];
        var private_company_id = jQuery('#add_accessions_file_private_company_select').val();

        get_select_box('private_companies', 'private_company_name_input', {
            'name': 'add_accessions_list_private_company_select',
            'id': 'add_accessions_list_private_company_select',
            'selected': private_company_id
        });

        var doFuzzySearch = jQuery('#fuzzy_check_upload_accessions').is(':checked');

        var formData = new FormData();
        formData.append('new_accessions_upload_file', file);
        if (private_company_id) {
            formData.append('add_accessions_file_private_company_select', private_company_id);
        }
        if (doFuzzySearch) {
            formData.append('fuzzy_check_upload_accessions', 'on');
        }

        disable_ui();

        jQuery.ajax({
            url: '/ajax/accessions/verify_accessions_file',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                enable_ui();
                jQuery('#add_accessions_dialog').modal("hide");

                if (typeof response === 'string') {
                    try {
                        response = JSON.parse(response.replace(/<\/?pre[^>]*>/gi, '').trim());
                    } catch (e) {
                        console.error("Error parsing upload response:", response, e);
                        alert("An error occurred while parsing server response: " + e.message);
                        return;
                    }
                }
                console.log(response);

                if (response.error || response.error_string) {
                    fullParsedData = undefined;
                    alert(response.error || response.error_string);
                } else if (response.success) {
                    fullParsedData = response.full_data;
                    review_verification_results(doFuzzySearch, response, response.list_id);
                } else {
                    fullParsedData = undefined;
                    alert("An unknown error occurred. Please try again later or contact us for help.");
                }
            },
            error: function (xhr, status, error) {
                enable_ui();
                var msg = "An error occurred during file upload.";
                if (xhr.responseJSON && (xhr.responseJSON.error || xhr.responseJSON.error_string)) {
                    msg += " " + (xhr.responseJSON.error || xhr.responseJSON.error_string);
                } else if (xhr.responseText) {
                    try {
                        var parsed = JSON.parse(xhr.responseText.replace(/<\/?pre[^>]*>/gi, '').trim());
                        if (parsed.error || parsed.error_string) {
                            msg += " " + (parsed.error || parsed.error_string);
                        }
                    } catch (e) {
                        msg += " " + error;
                    }
                } else if (error) {
                    msg += " " + error;
                }
                alert(msg);
            }
        });
    }

    jQuery('#new_accessions_submit').click(function () {
        var active_tab_href = jQuery('#add_new_accessions_tab_select li.active a').attr('href');
        var is_file_tab = active_tab_href === '#with_file_tab' ||
                          jQuery('#with_file_tab').hasClass('active') ||
                          jQuery('#with_file_tab').is(':visible') ||
                          jQuery('#add_new_accessions_file_tab').hasClass('active');
        var is_list_tab = active_tab_href === '#with_list_tab' ||
                          jQuery('#with_list_tab').hasClass('active') ||
                          jQuery('#add_new_accessions_list_tab').hasClass('active');

        var uploadFileInput = document.getElementById("new_accessions_upload_file");
        if (uploadFileInput && uploadFileInput.files && uploadFileInput.files.length > 0) {
            is_file_tab = true;
            is_list_tab = false;
        }

        if (is_file_tab) {
            verify_accessions_file();
        } else if (is_list_tab) {
            accession_list_id = jQuery('#list_div_list_select').val();
            if (!accession_list_id) {
                alert("Please select a list of accessions (\u8acb\u9078\u64c7\u7a2e\u539f\u6e05\u55ae)");
                return;
            }
            fullParsedData = undefined;
            verify_accession_list(accession_list_id);
            jQuery('#add_accessions_dialog').modal("hide");
        } else {
            alert("Please select either 'Using Lists' or 'Uploading a File' (\u8acb\u9078\u64c7\u4f7f\u7528\u6e05\u55ae\u6216\u4e0a\u50b3\u6a94\u6848)");
        }
    });

    jQuery(document).on('click', '[name="add_accessions_link"]', function () {
        var list = new CXGN.List();
        accessionList = [];
        accession_list_id = null;
        validSpecies = null;
        fuzzyResponse = null;
        fullParsedData = undefined;
        infoToAdd = [];
        accessionListFound = {};
        speciesNames = [];
        doFuzzySearch = null;
        jQuery('#new_accessions_upload_file').val('');
        jQuery('#add_accessions_dialog').modal("show");
        jQuery('#review_found_matches_dialog').modal("hide");
        jQuery('#review_fuzzy_matches_dialog').modal("hide");
        jQuery('#review_absent_dialog').modal("hide");
        jQuery("#list_div").html(list.listSelect("list_div", ["accessions"], undefined, undefined, undefined));
    });

    jQuery('#accessions_upload_spreadsheet_format_info').click(function(){
        jQuery('#accessions_upload_spreadsheet_format_modal').modal("show");
    });

    jQuery('body').on('hidden.bs.modal', '.modal', function () {
        jQuery(this).removeData('bs.modal');
    });

	jQuery(document).on('change', 'select[name="fuzzy_option"]', function() {
		var value = jQuery(this).val();
		if (jQuery('#add_accession_fuzzy_option_all').is(":checked")){
			jQuery('select[name="fuzzy_option"] option[value='+value+']').attr('selected','selected');
		}
	});

    jQuery('#review_fuzzy_matches_download').click(function(){
        console.log(fuzzyResponse);
        openWindowWithPost(JSON.stringify(fuzzyResponse));
        //window.open('/ajax/accession_list/fuzzy_download?fuzzy_response='+JSON.stringify(fuzzyResponse));
    });

    jQuery('#review_absent_dialog').on('shown.bs.modal', function (e) {
        if (jQuery.fn.DataTable.isDataTable('#infoToAdd_updated_table')) {
            jQuery('#infoToAdd_updated_table').DataTable().destroy();
        }
        if (jQuery.fn.DataTable.isDataTable('#infoToAdd_new_table')) {
            jQuery('#infoToAdd_new_table').DataTable().destroy();
        }
        if (jQuery('#infoToAdd_updated_table').length && jQuery('#infoToAdd_updated_table tbody tr').length) {
            jQuery('#infoToAdd_updated_table').DataTable({ destroy: true });
        }
        if (jQuery('#infoToAdd_new_table').length && jQuery('#infoToAdd_new_table tbody tr').length) {
            jQuery('#infoToAdd_new_table').DataTable({ destroy: true });
        }
    });

    jQuery('#add_accessions_saved_message_modal').on('hidden.bs.modal', function () {
        location.reload();
    });
    jQuery('#close_add_accessions_saved_message_modal').click(function () {
        location.reload();
    });

});

function openWindowWithPost(fuzzyResponse) {
    var f = document.getElementById('add_accession_fuzzy_match_download');
    f.fuzzy_response.value = fuzzyResponse;
    window.open('', 'TheWindow');
    f.submit();
}

function verify_accession_list(accession_list_id) {
    accession_list = JSON.stringify(list.getList(accession_list_id));
    doFuzzySearch = jQuery('#fuzzy_check').is(':checked');

    jQuery.ajax({
        type: 'POST',
        url: '/ajax/accession_list/verify',
        timeout: 36000000,
        //async: false,
        dataType: "json",
        data: {
            'accession_list': accession_list,
            'do_fuzzy_search': doFuzzySearch,
        },
        beforeSend: function(){
            disable_ui();
        },
        success: function (response) {
            enable_ui();
            if (response.error) {
                alert(response.error);
            }
            review_verification_results(doFuzzySearch, response, accession_list_id);
        },
        error: function (response) {
            enable_ui();
	    console.log(response.responseText);

            alert('An error occurred in processing. sorry'+response.responseText);
        }
    });
}

function review_verification_results(doFuzzySearch, verifyResponse, accession_list_id){
    var i;
    var j;
    accessionListFound = {};
    accessionList = (verifyResponse.absent || []).slice(0);
    infoToAdd = [];
    speciesNames = [];
    //console.log(verifyResponse);
    //console.log(accession_list_id);

    if (verifyResponse.full_data){
        for(var key in verifyResponse.full_data){
            infoToAdd.push(verifyResponse.full_data[key]);
            speciesNames.push(verifyResponse.full_data[key]['species']);
        }
    }

    function proceed_after_found_matches() {
        if (verifyResponse.fuzzy && verifyResponse.fuzzy.length > 0 && doFuzzySearch){
            jQuery('#review_fuzzy_matches_dialog').modal('show');
        } else {
            jQuery('#review_fuzzy_matches_dialog').modal('hide');
            if ((verifyResponse.absent && verifyResponse.absent.length > 0) || infoToAdd.length > 0){
                populate_review_absent_dialog(verifyResponse.absent || [], infoToAdd);
            } else {
                alert('All accessions in your list already exist in the database (\u6e05\u55ae\u4e2d\u6240\u6709\u7a2e\u539f\u7686\u5df2\u5b58\u5728\u65bc\u8cc7\u6599\u5eab\u4e2d)\u3002');
            }
        }
    }

    if (verifyResponse.found && verifyResponse.found.length > 0) {
        jQuery('#count_of_found_accessions').html("\u5df2\u5b58\u5728\u65bc\u8cc7\u6599\u5eab\u7684\u7a2e\u539f\u7e3d\u6578 (Total number already in the database: " + verifyResponse.found.length + ")");
        var found_html = '<table class="table table-bordered table-striped" id="found_accessions_table"><thead><tr><th>\u641c\u5c0b\u540d\u7a31(Search Name)</th><th>\u8cc7\u6599\u5eab\u73fe\u5b58\u540d\u7a31(Found in Database)</th></tr></thead><tbody>';
        for( i=0; i < verifyResponse.found.length; i++){
            found_html = found_html
                +'<tr><td>'+verifyResponse.found[i].matched_string
                +'</td><td>'
                +verifyResponse.found[i].unique_name
                +'</td></tr>';
            accessionListFound[verifyResponse.found[i].unique_name] = 1;
        }
        found_html = found_html +'</tbody></table>';

        jQuery('#view_found_matches').html(found_html);

        jQuery('#review_found_matches_dialog').modal('show');

        if (jQuery.fn.DataTable.isDataTable('#found_accessions_table')) {
            jQuery('#found_accessions_table').DataTable().destroy();
        }
        jQuery('#found_accessions_table').DataTable({ destroy: true });

        jQuery('#review_found_matches_hide').off('click').on('click', function(){
            jQuery('#review_found_matches_dialog').modal('hide');
            proceed_after_found_matches();
        });
    } else {
        proceed_after_found_matches();
    }

    if (verifyResponse.fuzzy && verifyResponse.fuzzy.length > 0 && doFuzzySearch) {
        fuzzyResponse = verifyResponse.fuzzy;
        var fuzzy_html = '<table id="add_accession_fuzzy_table" class="table table-bordered"><thead><tr><th class="col-xs-4">\u6e05\u55ae\u4e2d\u7684\u540d\u7a31(Name in Your List)</th><th class="col-xs-4">\u8cc7\u6599\u5eab\u73fe\u5b58\u540d\u7a31(Existing Name(s) in Database)</th><th class="col-xs-4">\u9078\u9805(Options)&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="add_accession_fuzzy_option_all"/> \u5957\u7528\u81f3\u6240\u6709\u9805\u76ee(Use Same Option for All)</th></tr></thead><tbody>';
        for( i=0; i < verifyResponse.fuzzy.length; i++) {
            fuzzy_html = fuzzy_html + '<tr id="add_accession_fuzzy_option_form'+i+'"><td>'+ verifyResponse.fuzzy[i].name + '<input type="hidden" name="fuzzy_name" value="'+ verifyResponse.fuzzy[i].name + '" /></td>';
            fuzzy_html = fuzzy_html + '<td><select class="form-control" name ="fuzzy_select">';
            for(j=0; j < verifyResponse.fuzzy[i].matches.length; j++){
                if (verifyResponse.fuzzy[i].matches[j].is_synonym){
                    fuzzy_html = fuzzy_html + '<option value="' + verifyResponse.fuzzy[i].matches[j].synonym_of + '">' + verifyResponse.fuzzy[i].matches[j].name + ' (SYNONYM OF: '+verifyResponse.fuzzy[i].matches[j].synonym_of+')</option>';
                } else {
                    fuzzy_html = fuzzy_html + '<option value="' + verifyResponse.fuzzy[i].matches[j].name + '">' + verifyResponse.fuzzy[i].matches[j].name + '</option>';
                }
            }
            fuzzy_html = fuzzy_html + '</select></td><td><select class="form-control" name="fuzzy_option"><option value="keep">\u4fdd\u7559\u6e05\u55ae\u4e2d\u7684\u540d\u7a31\u7e7c\u7e8c\u5132\u5b58(Continue saving name in your list)</option><option value="replace">\u4ee5\u6b64\u73fe\u5b58\u540d\u7a31\u53d6\u4ee3\u6e05\u55ae\u4e2d\u7684\u540d\u7a31(Replace name in your list with selected existing name)</option><option value="remove">\u5ffd\u7565\u4e26\u81ea\u6e05\u55ae\u4e2d\u79fb\u9664(Remove name in your list and ignore)</option><option value="synonymize">\u5c07\u6e05\u55ae\u4e2d\u7684\u540d\u7a31\u65b0\u589e\u70ba\u73fe\u5b58\u540d\u7a31\u7684\u540c\u7fa9\u8a5e(Add name in your list as a synonym to selected existing name)</option></select></td></tr>';
        }
        fuzzy_html = fuzzy_html + '</tbody></table>';
        jQuery('#view_fuzzy_matches').html(fuzzy_html);

        //Add to absent
        for( i=0; i < verifyResponse.fuzzy.length; i++) {
            if (accessionList.indexOf(verifyResponse.fuzzy[i].name) === -1) {
                accessionList.push(verifyResponse.fuzzy[i].name);
            }
        }
    }

    jQuery(document).off('click', '#review_fuzzy_matches_continue').on('click', '#review_fuzzy_matches_continue', function(){
        process_fuzzy_options(accession_list_id);
    });

}

function populate_review_absent_dialog(absent, infoToAdd){
    absent = absent || [];
    infoToAdd = infoToAdd || [];
    console.log(infoToAdd);
    console.log(absent);

    var count_to_show = infoToAdd.length > 0 ? infoToAdd.length : absent.length;
    jQuery('#count_of_absent_accessions').html("\u5f85\u65b0\u589e\u7e3d\u6578(Total number to be added)\uff1a" + count_to_show);
    var absent_html = '';
    jQuery("#species_name_input").autocomplete({
        source: '/organism/autocomplete'
    });

    for( i=0; i < absent.length; i++){
        absent_html = absent_html
        +'<div class="left" style="margin-right:10px; margin-bottom:5px;"><span class="label label-default" style="font-size:13px;">'+absent[i]
        +'</span></div>';
    }
    jQuery('#view_absent').html(absent_html);
    jQuery('#view_infoToAdd').html('');

    if (infoToAdd.length>0){
        var new_rows = '';
        var update_rows = '';
        for (i = 0; i < infoToAdd.length; i++) {
            var item = infoToAdd[i];
            var is_update = ('stock_id' in item) && item['stock_id'];
            var acc_name = item['germplasmName'] || item['defaultDisplayName'] || item['uniquename'] || '';
            var prop_parts = [];
            for (var key in item) {
                if (key != 'uniquename' && key != 'germplasmName' && key != 'defaultDisplayName' && key != 'other_editable_stock_props' && key != 'stock_id') {
                    var val = item[key];
                    if (val !== undefined && val !== null && val !== '') {
                        if (Array.isArray(val)) {
                            var formatted_arr = val.map(function(v) {
                                if (typeof v === 'object' && v !== null) {
                                    return Object.keys(v).map(function(k){ return k + ':' + v[k]; }).join('; ');
                                }
                                return v;
                            }).join(', ');
                            if (formatted_arr) {
                                prop_parts.push('<b>' + key + '</b>: ' + formatted_arr);
                            }
                        } else if (typeof val === 'object') {
                            prop_parts.push('<b>' + key + '</b>: ' + JSON.stringify(val));
                        } else {
                            prop_parts.push('<b>' + key + '</b>: ' + val);
                        }
                    }
                } else if (key == 'other_editable_stock_props' && item[key]) {
                    for (var key_other in item[key]) {
                        var oval = item[key][key_other];
                        if (oval !== undefined && oval !== null && oval !== '') {
                            prop_parts.push('<b>' + key_other + '</b>: ' + oval);
                        }
                    }
                }
            }
            var row_html = '<tr><td>' + acc_name + '</td><td>' + prop_parts.join('&nbsp; | &nbsp;') + '</td></tr>';
            if (is_update) {
                update_rows += row_html;
            } else {
                new_rows += row_html;
            }
        }

        var infoToAdd_html = '';
        if (new_rows !== '') {
            infoToAdd_html += '<div class="well"><b>\u4ee5\u4e0b\u5c07\u65b0\u589e\u7684\u65b0\u7a2e\u539f(The following new accessions will be added)\uff1a</b><br/><br/><table id="infoToAdd_new_table" class="table table-bordered table-hover"><thead><tr><th>\u7a2e\u539f\u540d\u7a31(Accession Name)</th><th>\u5c6c\u6027\u8cc7\u8a0a(Properties)</th></tr></thead><tbody>' + new_rows + '</tbody></table></div>';
        }
        if (update_rows !== '') {
            infoToAdd_html += '<div class="well"><b>\u4ee5\u4e0b\u5c07\u66f4\u65b0\u7684\u7a2e\u539f(The following accessions will be updated)\uff1a</b><br/><br/><table id="infoToAdd_updated_table" class="table table-bordered table-hover"><thead><tr><th>\u7a2e\u539f\u540d\u7a31(Accession Name)</th><th>\u5c6c\u6027\u8cc7\u8a0a(Properties)</th></tr></thead><tbody>' + update_rows + '</tbody></table></div>';
        }
        jQuery('#view_infoToAdd').html(infoToAdd_html);
        jQuery('#add_accessions_using_list_inputs').hide();
    } else {
        jQuery('#add_accessions_using_list_inputs').show();
    }

    jQuery('#review_absent_dialog').modal('show');
}

function process_fuzzy_options(accession_list_id) {
    var data={};
    jQuery('#add_accession_fuzzy_table').find('tr').each(function(){
        var id=jQuery(this).attr('id');
        if (id !== undefined){
            var row={};
            jQuery(this).find('input,select').each(function(){
                var type = jQuery(this).attr('type');
                if (type == 'radio'){
                    if (jQuery(this).is(':checked')){
                        row[jQuery(this).attr('name')]=jQuery(this).val();
                    }
                } else {
                    row[jQuery(this).attr('name')]=jQuery(this).val();
                }
            });
            data[id]=row;
        }
    });
    console.log(data);
    jQuery.ajax({
        type: 'POST',
        url: '/ajax/accession_list/fuzzy_options',
        dataType: "json",
        data: {
            'accession_list_id': accession_list_id,
            'fuzzy_option_data': JSON.stringify(data),
            'names_to_add': JSON.stringify(accessionList)
        },
        success: function (response) {
            //console.log(response);
            infoToAdd = [];
            speciesNames = [];
            accessionList = response.names_to_add;
            if (accessionList.length > 0){

                if (fullParsedData != null){
                    for (var i=0; i<accessionList.length; i++){
                        var accession_name = accessionList[i];
                        if (fullParsedData[accession_name]) {
                            infoToAdd.push(fullParsedData[accession_name]);
                            speciesNames.push(fullParsedData[accession_name]['species']);
                        }
                    }
                    for (var accession_name in accessionListFound) {
                        if (accessionListFound.hasOwnProperty(accession_name) && fullParsedData[accession_name]) {
                            infoToAdd.push(fullParsedData[accession_name]);
                            speciesNames.push(fullParsedData[accession_name]['species']);
                        }
                    }
                }
                populate_review_absent_dialog(accessionList, infoToAdd);
                jQuery('#review_absent_dialog').modal('show');
            } else {
                alert('All accessions in your list now exist in the database (\u6e05\u55ae\u4e2d\u6240\u6709\u7a2e\u539f\u7686\u5df2\u5b58\u5728\u65bc\u8cc7\u6599\u5eab\u4e2d)\u3002');
            }
        },
        error: function () {
            alert('An error occurred checking your fuzzy options! Do not try to add a synonym to a synonym! Also do not use any special characters!');
        }
    });
}
