
jQuery(document).ready(function (){

    get_select_box('genotyping_protocol','selected_protocol', {'empty':1});

    var lo = new CXGN.List();
    jQuery('#selected_marker_set1').html(lo.listSelect('selected_marker_set1', ['markers'], '選取標記組(Select a markerset)', 'refresh', 'hide_public_lists' ));

    var list = new CXGN.List();
    jQuery('#selected_marker_set2').html(list.listSelect('selected_marker_set2', ['markers'], '選取標記組(Select a markerset)', 'refresh', undefined));


    jQuery("#save_marker_set").click(function(){
        var name = $('#new_marker_set').val();
        if (!name) {
            alert("標記組名稱為必填項目(Markerset name is required)");
            return;
        }

        var protocol_id = $('#selected_protocol').val();
        if (!protocol_id) {
            alert("基因型鑑定協定為必填項目(Genotyping protocol is required)");
            return;
        }

        var data_type = $('#genotyping_data_type').val();
        if (!data_type) {
            alert("基因型資料類型為必填項目(Genotyping data type is required)");
            return;
        }

        var protocol_name = $('#selected_protocol').find(":selected").text();
        var desc = $('#marker_set_desc').val();

        if (!desc) {
            alert("請提供描述(Please provide description)");
            return;
        }

        var list_id = lo.newList(name, desc);
        lo.setListType(list_id, 'markers');

        var markersetProtocol = {};
        markersetProtocol.genotyping_protocol_name = protocol_name;
        markersetProtocol.genotyping_protocol_id = protocol_id;
        markersetProtocol.genotyping_data_type = data_type;

        var markersetProtocolString = JSON.stringify(markersetProtocol);

        var protocolAdded = lo.addToList(list_id, markersetProtocolString);
        if (protocolAdded){
            alert ("已新增標記組(Added new markerset): " + name + " ，用於基因型協定(for genotyping protocol): " + protocol_name + " ，資料類型(data type): " + data_type);
        }
        location.reload();
        return list_id;

    });

    var markersetType;
    jQuery(document).on("change", "#selected_marker_set1", function() {

        var markersetID = jQuery('#selected_marker_set1').val();

        jQuery.ajax({
            url: '/markerset/type',
            data: {'markerset_id': markersetID},
            success: function(response) {
                markersetType = response.type;
                if (markersetType == "Dosage") {
                    jQuery("#markerset_dosage_section").show();
                    jQuery("#markerset_snp_section").hide();
                    jQuery("#markerset_download_section").hide();
                } else if (markersetType == "SNP") {
                    jQuery("#markerset_snp_section").show();
                    jQuery("#markerset_dosage_section").hide();
                    jQuery("#markerset_download_section").hide();
                } else if (markersetType == "Download") {
                    jQuery("#markerset_download_section").show();
                    jQuery("#markerset_dosage_section").hide();
                    jQuery("#markerset_snp_section").hide();
                } else {
                    jQuery("#markerset_snp_section").hide();
                    jQuery("#markerset_dosage_section").hide();
                    jQuery("#markerset_download_section").hide();
                }
            },
        });
    });

    jQuery("#add_marker").click(function(){
        var markerInfo = {};

        var markerSetID = $('#selected_marker_set1').val();
        if (markerSetID == '') {
            alert("標記組名稱為必填項目(Markerset name is required)");
            return;
        }

        if (markersetType == "Dosage") {
            var markerNameDosage = $('#marker_name_dosage').val();
            var dosage = $('#allele_dosage').val();

            if (markerNameDosage == '') {
                alert("標記名稱為必填項目(Marker name is required)");
                return;
            }
            if (dosage == '') {
                alert("請指定劑量(Please indicate a dosage)");
                return;
            }

            markerInfo.marker_name = markerNameDosage;
            markerInfo.allele_dosage = dosage;
            var markerInfoString = JSON.stringify(markerInfo);

            var markerAdded = lo.addToList(markerSetID, markerInfoString);
            if (markerAdded){
                alert("已新增(Added) "+markerInfoString);
            }
        }

        if (markersetType == "SNP") {
            var markerNameSNP = $('#marker_name_snp').val();
            var allele1 = $('#allele_1').val();
            var allele2 = $('#allele_2').val();

            if (markerNameSNP == '') {
                alert("標記名稱為必填項目(Marker name is required)");
                return;
            }
            if ((allele1 == '') || ( allele2 == '')) {
                alert("請指定 SNP 等位基因(Please indicate SNP alleles)");
                return;
            }

            markerInfo.marker_name = markerNameSNP;
            markerInfo.allele1 = allele1;
            markerInfo.allele2 = allele2;
            var markerInfoString = JSON.stringify(markerInfo);

            var markerAdded = lo.addToList(markerSetID, markerInfoString);
            if (markerAdded){
                alert("已新增(Added) "+markerInfoString);
            }
        }

        if (markersetType == "Download") {
            var markerNameArray = [];
            var markerNameDownload = $('#marker_name_download').val();

            if (markerNameDownload == '') {
                alert("標記名稱為必填項目(Marker name is required)");
                return;
            }

            var markerNames = markerNameDownload.split("\n");

            for (let i = 0; i < markerNames.length; i++) {
                markerInfo.marker_name = markerNames[i];
                markerInfoString = JSON.stringify(markerInfo);
                markerNameArray.push(markerInfoString);
            }
            var markerAdded = lo.addBulk(markerSetID, markerNameArray);
            if (markerAdded){
                alert("已新增(Added) "+markerNameArray);
            }

        }

        location.reload();
        return markerSetName;

    });

    jQuery("#add_parameters").click(function(){
        var markerSetName = $('#selected_marker_set2').val();
        if (!markerSetName) {
            alert("標記組名稱為必填項目(Markerset name is required)");
            return;
        }

        var chromosomeNumber = $('#chromosome_number').val();
        var startPosition  = $('#start_position').val();
        var endPosition = $('#end_position').val();
        var markerName = $('#marker_name2').val();
        var snpAllele = $('#snp_allele').val();
        var quality = $('#quality').val();
        var filterStatus = $('#filter_status').val();

        var vcfParameters = {};

        if (chromosomeNumber) {
            vcfParameters.chromosome = chromosomeNumber
        }

        if (startPosition) {
            vcfParameters.start_position = startPosition
        }

        if (endPosition) {
            vcfParameters.end_position = endPosition
        }

        if (markerName) {
            vcfParameters.marker_name = markerName
        }

        if (snpAllele) {
            vcfParameters.snp_allele = snpAllele
        }

        if (quality) {
            vcfParameters.quality_score = quality
        }

        if (filterStatus) {
            vcfParameters.filter_status = filterStatus
        }

        var parametersString = JSON.stringify(vcfParameters);

        var markerAdded = list.addToList(markerSetName, parametersString);
        if (markerAdded) {
            alert("已新增(Added) "+parametersString);
        }
        location.reload();
        return markerSetName;

    });

    show_table();

});

function show_table() {
    var markersets_table = jQuery('#marker_sets').DataTable({
        'destroy': true,
        'ajax':{'url': '/marker_sets/available'},
        'columns': [
            {title: "標記組名稱(Markerset Name)", "data": "markerset_name"},
            {title: "標記數量(Number of Markers)", "data": "number_of_markers"},
            {title: "描述(Description)", "data": "description"},
            {title: "", "data": "null", "render": function (data, type, row) {return "<a onclick = 'showMarkersetDetail("+row.markerset_id+")'>詳細資訊(Detail)</a>" ;}},
            {title: "", "data": "null", "render": function (data, type, row) {return "<a onclick = 'removeMarkerSet("+row.markerset_id+")'>刪除(Delete)</a>" ;}},
        ],
    });
}

function removeMarkerSet (markerset_id){
    if (confirm("確定要刪除此標記組嗎？此操作無法復原。(Are you sure you want to delete this markerset? This cannot be undone)")){
        jQuery.ajax({
            url: '/markerset/delete',
            data: {'markerset_id': markerset_id},
            beforeSend: function(){
                jQuery('#working_modal').modal('show');
            },
            success: function(response) {
                jQuery('#working_modal').modal('hide');
                if (response.success == 1) {
                    alert("標記組已成功刪除。(The markerset has been deleted.)");
                    location.reload();
                }
                if (response.error) {
                    alert(response.error);
                }
            },
            error: function(response){
                jQuery('#working_modal').modal('hide');
                alert('刪除標記組時發生錯誤(An error occurred deleting markerset)');
            }
        });
    }
}


function showMarkersetDetail (markerset_id){
    jQuery.ajax({
        url: '/markerset/items',
        data: {'markerset_id': markerset_id},
        beforeSend: function(){
            jQuery('#working_modal').modal('show');
        },
        success: function(response) {
            jQuery('#working_modal').modal('hide');
            if (response.success == 1) {
                jQuery('#markerset_detail_dialog').modal('show');
                var markerset_detail_table = jQuery('#markerset_detail_table').DataTable({
                    'destroy': true,
                    'data': response.data,
                    'columns': [
                        {title: "項目(Item)", "data": "item_name"},
                    ],
                });
            } else {
                alert(response.error);
            }
        },
        error: function(response){
            jQuery('#working_modal').modal('hide');
            alert('取得標記組詳細資訊時發生錯誤(An error occurred getting markerset detail)');
        }
    });
}
