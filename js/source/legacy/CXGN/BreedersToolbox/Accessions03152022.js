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
                    var html = '已成功新增以下種原 (The following stocks were added)：<br/><br/>';
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

    jQuery('#new_accessions_submit').click(function () {
        var is_list_tab = jQuery('#add_new_accessions_list_tab').hasClass('active');
        var is_file_tab = jQuery('#add_new_accessions_file_tab').hasClass('active');
        if (!is_list_tab && !is_file_tab) {
            var selected_tab = jQuery('#add_new_accessions_tab_select .active').text();
            if (selected_tab.indexOf('Using Lists') !== -1 || selected_tab.indexOf('使用清單') !== -1) {
                is_list_tab = true;
            } else if (selected_tab.indexOf('Uploading a File') !== -1 || selected_tab.indexOf('上傳檔案') !== -1) {
                is_file_tab = true;
            }
        }

        if (is_list_tab) {
            accession_list_id = jQuery('#list_div_list_select').val();
            fullParsedData = undefined;
            verify_accession_list(accession_list_id);
        } else if (is_file_tab) {
            var uploadFile = jQuery("#new_accessions_upload_file").val();
            jQuery('#upload_new_accessions_form').attr("action", "/ajax/accessions/verify_accessions_file");
            if (uploadFile === '') {
                alert("Please select a file (請選擇檔案)");
                return;
            }

            get_select_box('private_companies', 'private_company_name_input', { 'name': 'add_accessions_list_private_company_select', 'id': 'add_accessions_list_private_company_select', 'selected':jQuery('#add_accessions_file_private_company_select').val() });

            jQuery("#upload_new_accessions_form").submit();
        }
        jQuery('#add_accessions_dialog').modal("hide");
    });

    jQuery('#upload_new_accessions_form').iframePostForm({
        json: false,
        post: function () {
            var uploadedSeedlotFile = jQuery("#new_accessions_upload_file").val();
            jQuery('#working_modal').modal("show");
            if (uploadedSeedlotFile === '') {
                jQuery('#working_modal').modal("hide");
            }
        },
        complete: function (r) {
            //alert("DONE WITH UPLOAD "+r);
            var clean_r = r.replace(/<\/?pre[^>]*>/gi, '').trim();
            var response;
            try {
                response = JSON.parse(clean_r);
            } catch (e) {
                console.error("Error parsing upload response:", clean_r, e);
                jQuery('#working_modal').modal("hide");
                alert("An error occurred while parsing server response: " + e.message);
                return;
            }
            console.log(response);
            jQuery('#working_modal').modal("hide");

            if (response.error || response.error_string) {
                fullParsedData = undefined;
                alert(response.error || response.error_string);
            }
            else if (response.success) {
                fullParsedData = response.full_data;
                doFuzzySearch = jQuery('#fuzzy_check_upload_accessions').is(':checked');
                review_verification_results(doFuzzySearch, response, response.list_id);
            }
            else {
                fullParsedData = undefined;
                alert("An unknown error occurred.  Please try again later or contact us for help.");
            }
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
                alert('All accessions in your list already exist in the database (清單中所有種原皆已存在於資料庫中)。');
            }
        }
    }

    if (verifyResponse.found && verifyResponse.found.length > 0) {
        jQuery('#count_of_found_accessions').html("已存在於資料庫的種原總數 (Total number already in the database: " + verifyResponse.found.length + ")");
        var found_html = '<table class="table table-bordered table-striped" id="found_accessions_table"><thead><tr><th>搜尋名稱(Search Name)</th><th>資料庫現存名稱(Found in Database)</th></tr></thead><tbody>';
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
        var fuzzy_html = '<table id="add_accession_fuzzy_table" class="table table-bordered"><thead><tr><th class="col-xs-4">清單中的名稱(Name in Your List)</th><th class="col-xs-4">資料庫現存名稱(Existing Name(s) in Database)</th><th class="col-xs-4">選項(Options)&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="add_accession_fuzzy_option_all"/> 套用至所有項目(Use Same Option for All)</th></tr></thead><tbody>';
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
            fuzzy_html = fuzzy_html + '</select></td><td><select class="form-control" name="fuzzy_option"><option value="keep">保留清單中的名稱繼續儲存(Continue saving name in your list)</option><option value="replace">以此現存名稱取代清單中的名稱(Replace name in your list with selected existing name)</option><option value="remove">忽略並自清單中移除(Remove name in your list and ignore)</option><option value="synonymize">將清單中的名稱新增為現存名稱的同義詞(Add name in your list as a synonym to selected existing name)</option></select></td></tr>';
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
    jQuery('#count_of_absent_accessions').html("待新增總數(Total number to be added)：" + count_to_show);
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
            infoToAdd_html += '<div class="well"><b>以下將新增的新種原(The following new accessions will be added)：</b><br/><br/><table id="infoToAdd_new_table" class="table table-bordered table-hover"><thead><tr><th>種原名稱(Accession Name)</th><th>屬性資訊(Properties)</th></tr></thead><tbody>' + new_rows + '</tbody></table></div>';
        }
        if (update_rows !== '') {
            infoToAdd_html += '<div class="well"><b>以下將更新的種原(The following accessions will be updated)：</b><br/><br/><table id="infoToAdd_updated_table" class="table table-bordered table-hover"><thead><tr><th>種原名稱(Accession Name)</th><th>屬性資訊(Properties)</th></tr></thead><tbody>' + update_rows + '</tbody></table></div>';
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
                alert('All accessions in your list now exist in the database (清單中所有種原皆已存在於資料庫中)。');
            }
        },
        error: function () {
            alert('An error occurred checking your fuzzy options! Do not try to add a synonym to a synonym! Also do not use any special characters!');
        }
    });
}
