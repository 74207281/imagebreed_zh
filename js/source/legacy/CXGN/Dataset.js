
var CXGN;
if (!CXGN) CXGN = function () { };

CXGN.Dataset = function () {
    this.dataset = [];
};


CXGN.Dataset.prototype = {

    // return info on all available datasets
    getDatasets: function() {
	var datasets=[];
	jQuery.ajax( {
	    'url' : '/ajax/dataset/by_user',
	    'async': false,
	    'success': function(response) {
		if (response.error) {
		    //alert(response.error);
		}
		    datasets = response;

	    },
            'error': function(response) {
		alert('發生錯誤。請再試一次。(An error occurred. Please try again.)');
	    }
	});
	return datasets;
    },

    // return info on public datasets
    getPublicDatasets: function() {
        var datasets=[];
        jQuery.ajax( {
            'url' : '/ajax/dataset/get_public',
            'async': false,
            'success': function(response) {
                if (response.error) {
                    //alert(response.error);
                }
                    datasets = response;

            },
            'error': function(response) {
                alert('發生錯誤。請再試一次。(An error occurred. Please try again.)');
            }
        });
        return datasets;
    },

    getDataset: function(id) {
	var dataset;
	jQuery.ajax( {
	    "url" : "/ajax/dataset/get/"+id,
	    "async": false,
	    "success": function(response) {
		if (response.error) {
		    alert(response.error);
		}
		else {
		    dataset = response.dataset;
		}
	    },
	    "error": function(response) {
		alert("發生錯誤。指定的資料集可能不存在。請再試一次。(An error occurred. The specified dataset may not exist. Please try again.)"+JSON.stringify(response));
	    }
	});
	return dataset;

    },

    deleteDataset: function(id) {
      	var dataset;
	jQuery.ajax( {
	    'url' : '/ajax/dataset/delete/'+id,
	    'async': false,
	    'success': function(response) {
		if (response.error) {
		    alert('刪除資料集時發生錯誤。(An error occurred during dataset deletion.) '+response.error);
		}
		else {
		    alert('資料集已刪除。(The dataset has been deleted.)');
		}
	    },
	    'error': function(response) {
		alert('發生錯誤。指定的資料集可能不存在。請再試一次。(An error occurred. The specified dataset may not exist. Please try again.)'+JSON.stringify(response));
		
	    }
	});
    },

    makePublicDataset: function(id) {
        var dataset;
        jQuery.ajax( {
            'url' : '/ajax/dataset/set_public/'+id,
            'async': false,
            'success': function(response) {
                if (response.error) {
                    alert('執行操作時發生錯誤。(An error occurred during action.) '+response.error);
		} else {
                    alert('資料集現在已公開。(The dataset is now public.)');
                }
            },
            'error': function(response) {
                alert('發生錯誤。指定的資料集可能不存在。請再試一次。(An error occurred. The specified dataset may not exist. Please try again.)'+JSON.stringify(response));

            }
        });
    },

   makePrivateDataset: function(id) {
        var dataset;
        jQuery.ajax( {
            'url' : '/ajax/dataset/set_private/'+id,
            'async': false,
            'success': function(response) {
                if (response.error) {
                    alert('執行操作時發生錯誤。(An error occurred during action.) '+response.error);
                } else {
                    alert('資料集現在已設為私人。(The dataset is now private.)');
                }
            },
            'error': function(response) {
                alert('發生錯誤。指定的資料集可能不存在。請再試一次。(An error occurred. The specified dataset may not exist. Please try again.)'+JSON.stringify(response));

            }
        });
    },

    datasetSelect: function(div_name, empty_element, refresh) {

  var datasets = new Array();
  datasets = this.getDatasets();
  var html = '<select class="form-control input-sm" id="'+div_name+'_dataset_select" name="'+div_name+'_dataset_select" >';
  if (empty_element) {
      html += '<option value="">'+empty_element+'</option>\n';
        }
  for (var n=0; n<datasets.length; n++) {
      html += '<option value='+datasets[n][0]+'>'+datasets[n][1]+'</option>';
  }
  if (refresh) {
    html = '<div class="input-group">'+html+'</select><span class="input-group-btn"><button class="btn btn-default" type="button" id="'+div_name+'_dataset_refresh" title="重新整理資料集(Refresh datasets)" onclick="refreshDatasetSelect(\''+div_name+'_dataset_select\',\'選項已重新整理。(Options refreshed.)\')"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span></button></span></div>';
    return html;
  }
  else {
    html = html + '</select>';
    return html;
  }
},

    renderDatasets: function(div) {
	var datasets = this.getDatasets();
	var html = '';

	if (!datasets || datasets.length===0) {
	    html = html + "無(None)";
	    jQuery('#'+div+'_div').html(html);
	    return;
	}

	html += '<table class="table table-hover table-condensed">';
	html += '<thead><tr><th>資料集名稱(Dataset Name)</th><th>描述(Description)</th><th colspan="4">操作(Actions)</th></tr></thead><tbody><tr>';
	for (var i = 0; i < datasets.length; i++) {
	    html += '<td><b>'+datasets[i][1]+'</b></td>';
	    html += '<td>'+datasets[i][2]+'</td>';
	    html += '<td><a title="檢視(View)" id="view_dataset_'+datasets[i][1]+'" href="javascript:showDatasetItems(\'dataset_item_dialog\','+datasets[i][0]+')"><span class="glyphicon glyphicon-th-list"></span></a></td>';
	    html += '<td><a title="刪除(Delete)" id="delete_dataset_'+datasets[i][1]+'" href="javascript:deleteDataset('+datasets[i][0]+')"><span class="glyphicon glyphicon-remove"></span></a></td></tr>';
	}
	html = html + '</tbody></table>';
	html += '<div id="list_group_select_action"></div>';

	jQuery('#'+div+'_div').html(html);
    },

    renderItems: function(div, dataset_id) {
	var dataset = this.getDataset(dataset_id);

	var html = "此資料集包含以下內容：(This dataset contains the following:)<br />";

	var zero_count = 0;
	for(var key in dataset.categories) {
	    if (dataset.categories.hasOwnProperty(key)) {
		if (dataset.categories[key]===null || dataset.categories[key].length===0) {
		    zero_count++;
		}
		else {		   
		    html += dataset.categories[key].length+" 個類型為 <b>"+key+"</b> 的元素(elements)<br />";
		}
	    }
	}

	if (zero_count === Object.keys(dataset.categories).length) { 
	    jQuery('#'+div).html("此資料集不包含任何選取的項目。(This dataset does not contain any selections.)");
	}
	else { 
	    jQuery('#'+div).html(html);
	}
    }
}

function refreshDatasetSelect(div_name, empty_element) {
  var l = new CXGN.Dataset();
  var datasets = l.getDatasets();
  var html;
  if (empty_element) {
      html += '<option value="">'+empty_element+'</option>\n';
        }
  for (var n=0; n<datasets.length; n++) {
      html += '<option value='+datasets[n][0]+'>'+datasets[n][1]+'</option>';
  }
  jQuery('#'+div_name).html(html);
}

function setUpDatasets() {
//    jQuery("button[name='datasets_link']").click(
//	function() { show_datasets(); }
//    );
}

function show_datasets() {
    jQuery('#dataset_dialog').modal("show");
    var l = new CXGN.Dataset();
    l.renderDatasets('dataset_dialog');
}

function deleteDataset(dataset_id) {
    var reply = confirm("確定要刪除 ID 為 "+dataset_id+" 的資料集嗎？請注意，刪除後將無法復原。(Are you sure you want to delete the dataset? This cannot be undone.)");

    if (reply) {
	jQuery.ajax( {
	    'url' : '/ajax/dataset/delete/'+dataset_id,
	    'success': function(response) {
		if (response.error) {
		    alert(response.error);
		}
		else {
		    alert('成功刪除 ID 為 '+dataset_id+' 的資料集。(Successfully deleted dataset)');
		}
	    },
	    'error': function(response) {
		alert('處理時發生錯誤。(A processing error occurred.)');
	    }
	})
    }

}

function showDatasetItems(div, dataset_id) {

    working_modal_show();

    var d = new CXGN.Dataset();

    jQuery('#'+div).html('hello!');
    
    d.renderItems(div, dataset_id);

    jQuery('#'+div).modal("show");

    working_modal_hide();
}
