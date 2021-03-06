<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/views/include/head.jsp" %>

<!-- Style CSS -->
<link rel="stylesheet" href="/resources/css/style.css?after" type="text/css">
<style type="text/css">

.faq { width:1000px; margin:0 auto; }
.q { cursor:pointer; margin-top:10px; }
.a { display:none; margin-top:10px; background:#f6f6f6; padding:5px; }

</style>
<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-latest.js"></script>
<style>
.listWrap { font-family:'Noto Sans KR', sans-serif; margin-bottom:20px; }
.listWrap .qa_li { position:relative; display:block; padding:0; border-bottom:1px solid #ededed; cursor:pointer; }
.listWrap .qa_li:first-child { border-top:1px solid #a6a6a6; }
.listWrap .qa_li .ca_name { margin-bottom:14px; font-weight:400; color:#999; font-size:18px; }
.listWrap .qa_li .q { color:#222; font-size:24px; transition:color 0.3s ease-out; }
.listWrap .qa_li:hover .q { color:#0a7ac8; }
.listWrap { font-family:'Noto Sans KR', sans-serif; margin-bottom:20px; }
.qa_li .faq { position:relative; display:block; padding:25px 100px 25px 120px; background:url('https://happyjung.diskn.com/data/lecture/icon_jquery_faq2_icon_q.png') 40px center no-repeat; }
.qa_li faq .iconDiv { position:absolute; right:40px; top:50%; -webkit-transform:translateY(-50%); -moz-transform:translateY(-50%); -o-transform:translateY(-50%); -ms-transform:translateY(-50%); transform:translateY(-50%); }
.qa_li .a { position:relative; display:none; padding:50px 120px; font-size:16px; color:#222; line-height:28px; background:#f6f6f6 url('https://happyjung.diskn.com/data/lecture/icon_jquery_faq2_icon_a.png') 40px center no-repeat; border-top:1px solid #e4e4e4; }
.modA { position:absolute; right:30px; bottom:30px; color:#e82b2b; }

.listWrap { font-family:'Noto Sans KR', sans-serif; margin-bottom:20px; }
.listWrap .qa_li { position:relative; display:block; padding:0; border-bottom:1px solid #ededed; cursor:pointer; }
.listWrap .qa_li:first-child { border-top:1px solid #a6a6a6; }
.listWrap .qa_li .ca_name { margin-bottom:14px; font-weight:400; color:#999; font-size:18px; }
.listWrap .qa_li .tit { color:#222; font-size:24px; transition:color 0.3s ease-out; }
.listWrap .qa_li:hover .tit { color:#0a7ac8; }
.qa_li .question { position:relative; display:block; padding:25px 100px 25px 120px; background:url('https://happyjung.diskn.com/data/lecture/icon_jquery_faq2_icon_q.png') 40px center no-repeat; }
.qa_li .question .iconDiv { position:absolute; right:40px; top:50%; -webkit-transform:translateY(-50%); -moz-transform:translateY(-50%); -o-transform:translateY(-50%); -ms-transform:translateY(-50%); transform:translateY(-50%); }
.qa_li .answer { position:relative; display:none; padding:40px 120px; font-size:16px; color:#222; line-height:28px; background:#f6f6f6 url('https://happyjung.diskn.com/data/lecture/icon_jquery_faq2_icon_a.png') 40px 40px no-repeat; border-top:2px solid #e4e4e4; }
.modA { position:absolute; right:30px; bottom:30px; color:#e82b2b; }

</style>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
       <!-- ***** Breadcumb Area Start ***** -->
    <section class="breadcumb-area bg-img gradient-background-overlay" style="background-image:url(/resources/img/bg-img/iotpage.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="breadcumb-content">
                        <h3 class="breadcumb-title">FAQ</h3>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** Breadcumb Area End ***** -->

<!-- ?????? -->
<section class="medilife-tabs-area section-padding-100">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="medilife-tabs-content">
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item"  style="width: 18%; text-align: center;">
                            <a class="nav-link active" id="institution-tab" data-toggle="tab" href="#institution" role="tab" aria-controls="institution" aria-selected="false">????????????/?????????</a>
                        </li>
                        <li class="nav-item"  style="width: 18%; text-align: center;">
                            <a class="nav-link" id="faq-tab" data-toggle="tab" href="#faq" role="tab" aria-controls="faq" aria-selected="false">My IoT</a>
                        </li>
                        <li class="nav-item"  style="width: 18%; text-align: center;">
                            <a class="nav-link" id="specialities-tab" data-toggle="tab" href="#specialities" role="tab" aria-controls="specialities" aria-selected="false">???????????????</a>
                        </li>
                        <li class="nav-item"  style="width: 18%; text-align: center;">
                            <a class="nav-link" id="laboratory-tab" data-toggle="tab" href="#laboratory" role="tab" aria-controls="laboratory" aria-selected="false">??????/??????/??????</a>
                        </li>
                        <li class="nav-item"  style="width: 18%; text-align: center;">
                            <a class="nav-link" id="emergencies-tab" data-toggle="tab" href="#emergencies" role="tab" aria-controls="emergencies" aria-selected="false">????????????</a>
                        </li>
                    </ul>

                    <div class="tab-content" id="myTabContent">
                        <div class="tab-pane fade show active" id="institution" role="tabpanel" aria-labelledby="institution-tab">
                            <div class="medilife-tab-content d-md-flex align-items-center">
                                <!-- ????????????/????????? Tab Text  -->
                                <div class="medilife-tab-text">
                                   <ul class = "listWrap">
                                   <h3>????????????/????????? FAQ</h3>     
                                   <li class = "qa_li">

                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">?????????/??????????????? ??????????????????. ????????? ???????????????.</div>
                                      <div class="a">???????????? 032-123-1234??? ??????????????? ?????? ????????????????????????.</div>
                                      </div>

                          </li>
                                     <li class = "qa_li">

                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">???????????? ???????????? ?????????.</div>
                                      <div class="a">????????? ????????? ???????????? ??????, ?????? ??? ???????????? ???????????? ?????? ????????????. <br />
                                                  <strong>??????, ???????????? ??? ?????? ???????????? ???????????? ???????????????.</strong></div>
                                      </div>

                          </li>
                                      <li class = "qa_li">
                                    
                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">??????????????? ???????????? ?????????.</div>
                                      <div class="a">???????????? ????????? ???????????? ??????, <br />
                                                  <strong>?????? ????????? > My Page > MY INFO > ?????? ?????? > ??????????????????</strong>?????? ????????? ??? ????????????.</div>
                                      </div>

                          </li>
                                     <li class = "qa_li">

                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">??????????????? ?????? ????????????.</div>
                                      <div class="a">????????? ???????????? ??????,<br /> 
                                                  <strong>?????? ????????? > My Page > MY INFO > ?????? ?????? > ????????????</strong> ????????? ???????????????.</div>
                                      </div>
                          </li>
                                </ul>
                             </div>
                        </div>
                     </div>
                        <div class="tab-pane fade" id="faq" role="tabpanel" aria-labelledby="faq-tab">
                            <div class="medilife-tab-content d-md-flex align-items-center">
                                <!-- My IoT Tab Text  -->
                                <div class="medilife-tab-text">
                                   <ul class = "listWrap">
                                   <h3>My IoT FAQ</h3>
                                   <li class = "qa_li">

                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">?????? ????????? ????????? ?????? ????????? ??? ??????????</div>
                                      <div class="a">?????? ????????? ???????????? 2??? ?????? ?????? ????????? ???????????? ?????? ?????? ??? ?????? ???????????? ??????????????? ????????????.</div>
                                      </div>

                          </li>
                                     <li class = "qa_li">

                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">???????????? ???????????? ?????? ???????????? ?????? ??? ??? ??????????</div>
                                      <div class="a">?????? ?????? ???????????? ???????????? ????????? ???????????? <strong>?????? ????????? > My Page > IOT INFO</strong>??? ?????? ????????? ???????????? ???????????? ?????? ????????? ?????? ???????????????.</div>
                                      </div>

                          </li>
                                      <li class = "qa_li">
                                    
                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">???????????? ????????? ????????? ??????????</div>
                                      <div class="a">?????? ?????? ????????? ?????? ????????? ?????? ???????????? ??????????????? ????????????. ?????? <br /><strong>?????? ????????? > NEWS</strong>?????? ???????????? ??????????????? ????????? ?????? ???????????? ???????????? ??? ????????????.</div>
									</div>

                          </li>
                                     </ul>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="specialities" role="tabpanel" aria-labelledby="specialities-tab">
                            <div class="medilife-tab-content d-md-flex align-items-center">
                                <!-- ??????????????? Tab Text  -->
                                <div class="medilife-tab-text">
                                   <ul class = "listWrap">
                                   <h3>??????????????? FAQ</h3>
                                   <li class = "qa_li">

                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">??????????????? ????????? ????????? ??????????</div>
                                      <div class="a"><strong>?????? ????????? > My Page > RESERVATION</strong>?????? ?????? ???????????????.<br />
                                                  ?????????????????? ?????? 09:00~18:00, 30??? ????????? ?????? ??? ??? ????????????.</div>
                                      </div>

                          </li>
                                     <li class = "qa_li">

                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">??????????????? ?????? ????????? ????????? ?????? ????????????????</div>
                                      <div class="a"><strong>?????? ????????? > My Page > MY INFO > ?????? ??????</strong>?????? ?????? ???????????????.</div>
                                      </div>

                          </li>
                                      <li class = "qa_li">
                                    
                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">??????????????? ?????? ?????? ??? ????????? ????????? ??? ??????????</div>
                                      <div class="a">??????/????????? ????????? ????????? ????????????,<br /> 
                                                  <strong>?????? ????????? > My Page > MY INFO > ?????? ??????</strong>?????? ?????? ??? ?????? ??????????????? ?????????.</div>
                                      </div>

                          </li>
                                     <li class = "qa_li">

                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">?????? ??? ?????????????????? ???????????? ????????????.</div>
                                      <div class="a"><strong>?????? ????????? > My Page > MY INFO > ?????? ?????? > ????????????</strong>??? ?????? ?????? ???????????????.</div>
                                      </div>
                          </li>
                                     </ul>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="laboratory" role="tabpanel" aria-labelledby="laboratory-tab">
                            <div class="medilife-tab-content d-md-flex align-items-center">
                                <!-- ??????/??????/?????? Tab Text  -->
                                <div class="medilife-tab-text">
                                   <ul class = "listWrap">
                                   <h3>??????/??????/?????? FAQ</h3>
                                   <li class = "qa_li">

                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">????????? ??? ?????? ??????????????? ????????????????</div>
                                      <div class="a">???????????? ??? ????????????(???????????????, ???????????????)??? ????????? ???????????? ??? ????????????.</div>
                                      </div>

                          </li>
                                     <li class = "qa_li">

                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">?????? ????????? ????????? ???????????? ????????????.</div>
                                      <div class="a"><strong>?????? ????????? > My Page > MY INFO > ????????????</strong>?????? ???????????? ??? ????????????.</div>
                                      </div>

                          </li>
                                      <li class = "qa_li">
                                    
                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">???????????? ??? ????????? ????????? ??? ?????????? ????????? ?????? ????????? ????????? ??????????????????????</div>
                                      <div class="a">???????????? ??? ????????? ?????? ????????????, ?????? ????????? ?????? ??????????????????<br>[T.032-123-1234]??? ??????????????? ????????? ?????? ????????????????????????.<br />
                                                  ???????????? ????????? ??? ???/?????? ?????? ?????????????????? ???????????? ???????????? ?????? ???????????????.</div>
                                      </div>

                          </li>
                                     <li class = "qa_li">

                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">????????? ?????? ??? ???????????? ????????????.</div>
                                      <div class="a"><strong>?????? ????????? > My Page > MY INFO > ???????????? > ????????????</strong>????????? ?????? ?????? ????????????, ????????? ?????? ??? ??????????????? ????????? ?????? 2~3????????? ????????? ??? ????????????.</div>
                                      </div>
                          </li>
                                     </ul>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="emergencies" role="tabpanel" aria-labelledby="emergencies-tab">
                            <div class="medilife-tab-content d-md-flex align-items-center">
                                <!-- ???????????? Tab Text  -->
                                <div class="medilife-tab-text">
                                  <ul class = "listWrap">
                                  <h3>???????????? FAQ</h3>
                                   <li class = "qa_li">

                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">?????????????????? ??????????????? ????????? ??????????</div>
                                      <div class="a">Fine-Apple ??????????????? ?????????????????? ??????????????? <br /><strong>??????(?????????~?????????) 09:00 ~18:00</strong>?????????.</div>
                                      </div>

                          </li>
                                     <li class = "qa_li">

                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">???????????? ??????????????? ?????? ????????? ????????? ??????????</div>
                                      <div class="a">?????? ????????? ????????? join_smarthome@fine-apple.com ??? ?????? ??????????????? ?????? ?????? ?????? ?????? ??????????????????. </div>
                                      </div>
                          </li>
                                     </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<div style="padding: 200px 0 0 0;"></div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>


<script type="text/javascript" src="/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/active.js"></script>
<script type="text/javascript" src="/resources/js/plugins.js"></script>

<script type="text/javascript" src="/resources/js/popper.min.js"></script>

</body>

</html>