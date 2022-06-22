function get_options(data)
{
    options = "<option value=" + data['scenario_id'] + ">" + data['title'] + "</option>";
    if(data['children'].length) 
    {
        for(let row of data['children']) options+=get_options(row);
    }
    return options;
}

function getdata(){
    $.ajax({
        url: 'get_data.php',
        success: function(data) {
            $('#chart_container').empty();
            var jsonObj = JSON.parse(data);
            var oc = $('#chart_container').orgchart(
                {
                    'data' : jsonObj,
                    'nodeId': 'scenario_id',
                    'nodeTitle': 'title',
                    'nodeContent': 'content',
                    'direction': 'l2r',
                }
            );
            options = get_options(jsonObj);
            $('.id').each(function(){
                $(this).find('option').not(':first').remove();
                $(this).append(options);
            });
        }
    });
}

$(document).on("ready",function(){
    $('#import_form').on('submit', function(event){
        event.preventDefault();
        $.ajax({
            url: "import.php",
            type: "post",
            data: new FormData(this),
            contentType:false,
            cache:false,
            processData:false,
            beforeSend:function(){
                $('#submit1').attr('disabled',true),
                $('#submit1').val('Importing...');
            },
            success:function(data){
                $('#import_form')[0].reset();
                $('#submit1').removeAttr("disabled");
                $('#submit1').val('Import');
            }
        });
    });

    $('#insert_form').on('submit', function(event){
        event.preventDefault();
        $.ajax({
            url: "insert.php",
            type: "post",
            data: new FormData(this),
            contentType:false,
            cache:false,
            processData:false,
            beforeSend:function(){
                $('#submit2').attr('disabled',true),
                $('#submit2').val('Inserting...');
            },
            success:function(data){
                if(data=="success") $.notify("Thêm kịch bản thành công","success");
                else $.notify("Thêm kịch bản thất bại");
                $('#insert_form')[0].reset();
                $('#submit2').removeAttr("disabled");
                $('#submit2').val('Insert');
                getdata();
            }
        });
    });

    $('#update_form').on('submit', function(event){
        event.preventDefault();
        $.ajax({
            url: "update.php",
            type: "post",
            data: new FormData(this),
            contentType:false,
            cache:false,
            processData:false,
            beforeSend:function(){
                $('#submit3').attr('disabled',true),
                $('#submit3').val('Updating...');
            },
            success:function(data){
                console.log(data);
                if(data == "success") $.notify("Sửa kịch bản thành công","success");
                else $.notify("Sửa kịch bản thất bại");
                $("#message").html(data);
                $('#update_form')[0].reset();
                $('#submit3').removeAttr("disabled");
                $('#submit3').val('Update');
                getdata();
            }
        });
    });

    $('#delete_form').on('submit', function(event){
        event.preventDefault();
        $.ajax({
            url: "delete.php",
            type: "post",
            data: new FormData(this),
            contentType:false,
            cache:false,
            processData:false,
            beforeSend:function(){
                $('#submit4').attr('disabled',true),
                $('#submit4').val('Deleting...');
            },
            success:function(data){
                if(data=="success") $.notify("Xóa kịch bản thành công","success");
                else $.notify("Xóa kịch bản thất bại");
                $('#update_form')[0].reset();
                $('#submit4').removeAttr("disabled");
                $('#submit4').val('Delete');
                getdata();
            }
        });
    });

    $("#add").on("click",function(){
        $("#insert_form").toggle();
        $("#delete_form").hide();
        $("#update_form").hide();
    });

    $("#remove").on("click",function(){
        $("#delete_form").toggle();
        $("#insert_form").hide();
        $("#update_form").hide();
    });

    $("#edit").on("click",function(){
        $("#update_form").toggle();
        $("#delete_form").hide();
        $("#insert_form").hide();
    });

    getdata();
});