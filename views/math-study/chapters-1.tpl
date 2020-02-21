{{ define "css" }}
    <style>
        input{text-align:center;border:none;border-bottom:3px solid #e83e8c;width:5rem;}
        input:focus{outline:none;border:none;border-bottom:3px solid #e83e8c;}
        .card{color:#e83e8c}
        .subject{display:inline-block;width:10rem;}
    </style>
{{ end }}

{{ define "content" }}

    <div class="container sub-container">
        <div class="row">
            <div class="col-lg-12">
                <div class="text-center"><img src="/public/image/yao-ming.jpg"></div>
                <input id="count" type="hidden" value="{{len .subjects}}">
                <h5 class="text-center">20以内的加减法共 {{.count}} 道题，每题 {{.score}} 分</h5>
                {{ range $v := .subjects }}
                <div class="card mt-4">
                    <div class="card-body bg-transparent text-center" style="font-size:2rem">
                        <i class="fa fa-question-circle text-black-50"></i>
                        <span class="subject">{{ $v.NumberOne }} {{ $v.Mark }} {{ $v.NumberTwo }} = </span>
                        <input data-result="{{ $v.Result }}" type="text" value="">
                    </div>
                </div>
                {{ end }}
                <button id="calculate" class="btn btn-lg btn-danger w-100 mt-4 mb-4">计算分数</button>
            </div>
        </div>
    </div>

    <!--模态框组件-->
    <div class="modal fade" id="result-modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3>提示</h3>
                </div>
                <div id="result" class="modal-body text-center">
                    <!--内容-->
                </div>
                <div class="modal-footer">
                    <button class="btn btn-info" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>

{{ end }}

{{ define "js" }}
    <script>
        $(function(){
            $("input").on("blur",function(){
                $(this).closest('.card').removeClass('border-info');
                if($(this).val() != ''){
                    if($(this).val() != $(this).data("result")){
                        $(this).closest('.card').removeClass('border-info').addClass('border-danger');
                        $(this).closest('.card').find('i').removeClass('fa-question-circle text-black-50').addClass('fa-close text-danger');
                    }else{
                        $(this).closest('.card').removeClass('border-info').addClass('border-success');
                        $(this).closest('.card').find('i').removeClass('fa-question-circle text-black-50').addClass('fa-check text-success');
                    }
                }
            });

            $("input").on("focus",function(){
                $(this).closest('.card').find('i').removeClass('fa-check text-success fa-close text-danger').addClass('fa-question-circle text-black-50');
                $(this).closest('.card').removeClass('border-danger border-success').addClass('border-info');
            });

            $("#calculate").on("click",function(){
                var correct = 0;
                $("input").each(function(i,item){
                    if($(item).val() == $(this).data("result")){
                        correct += 1;
                    }
                });
                var score = (100 * correct/$("#count").val());
                score = score%1 === 0?score:score.toFixed(2);
                var html = '';
                if( score >= 90 ) {
                    html += '<p><i class="fas fa-4x fa-award text-warning"></i></p><h4>恭喜，你获得: ' + score + ' 分</h4>';
                }else if( score >= 80 ) {
                    html += '<p><i class="fas fa-4x fa-smile-wink text-warning"></i></p><h4>恭喜，你获得: ' + score + ' 分</h4>';
                }else if( score >= 60 ) {
                    html += '<p><i class="fas fa-4x fa-frown-open text-warning"></i></p><h4>加油，你获得: ' + score + ' 分</h4>';
                }else {
                    html += '<p><i class="fas fa-4x fa-sad-cry text-warning"></i></p><h4>很遗憾，你获得: ' + score + ' 分</h4>';
                }
                $("#result").html(html);
                $("#result-modal").modal();
            });
        })
    </script>
{{ end }}