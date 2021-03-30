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

<!-- 메인 -->
<section class="medilife-tabs-area section-padding-100">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="medilife-tabs-content">
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item"  style="width: 18%; text-align: center;">
                            <a class="nav-link active" id="institution-tab" data-toggle="tab" href="#institution" role="tab" aria-controls="institution" aria-selected="false">회원가입/로그인</a>
                        </li>
                        <li class="nav-item"  style="width: 18%; text-align: center;">
                            <a class="nav-link" id="faq-tab" data-toggle="tab" href="#faq" role="tab" aria-controls="faq" aria-selected="false">My IoT</a>
                        </li>
                        <li class="nav-item"  style="width: 18%; text-align: center;">
                            <a class="nav-link" id="specialities-tab" data-toggle="tab" href="#specialities" role="tab" aria-controls="specialities" aria-selected="false">출장서비스</a>
                        </li>
                        <li class="nav-item"  style="width: 18%; text-align: center;">
                            <a class="nav-link" id="laboratory-tab" data-toggle="tab" href="#laboratory" role="tab" aria-controls="laboratory" aria-selected="false">결제/취소/환불</a>
                        </li>
                        <li class="nav-item"  style="width: 18%; text-align: center;">
                            <a class="nav-link" id="emergencies-tab" data-toggle="tab" href="#emergencies" role="tab" aria-controls="emergencies" aria-selected="false">일반문의</a>
                        </li>
                    </ul>

                    <div class="tab-content" id="myTabContent">
                        <div class="tab-pane fade show active" id="institution" role="tabpanel" aria-labelledby="institution-tab">
                            <div class="medilife-tab-content d-md-flex align-items-center">
                                <!-- 회원가입/로그인 Tab Text  -->
                                <div class="medilife-tab-text">
                                   <ul class = "listWrap">
                                   <h3>회원가입/로그인 FAQ</h3>     
                                   <li class = "qa_li">

                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">아이디/비밀번호를 분실했습니다. 어떻게 해야하나요.</div>
                                      <div class="a">대표전화 032-123-1234로 전화주시면 확인 도와드리겠습니다.</div>
                                      </div>

                          </li>
                                     <li class = "qa_li">

                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">아이디를 변경하고 싶어요.</div>
                                      <div class="a">아이디 변경을 원하시는 경우, 탈퇴 후 재가입을 원칙으로 하고 있습니다. <br />
                                                  <strong>※단, 회원탈퇴 후 동일 아이디로 재가입이 불가합니다.</strong></div>
                                      </div>

                          </li>
                                      <li class = "qa_li">
                                    
                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">개인정보를 변경하고 싶어요.</div>
                                      <div class="a">개인정보 변경을 원하시는 경우, <br />
                                                  <strong>상단 메뉴탭 > My Page > MY INFO > 나의 정보 > 회원정보수정</strong>에서 변경할 수 있습니다.</div>
                                      </div>

                          </li>
                                     <li class = "qa_li">

                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">회원탈퇴를 하고 싶습니다.</div>
                                      <div class="a">탈퇴를 원하시는 경우,<br /> 
                                                  <strong>상단 메뉴탭 > My Page > MY INFO > 나의 정보 > 회원탈퇴</strong> 신청이 가능합니다.</div>
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
                                      <div class="q" onclick="$(this).next().toggle()">결제 완료한 상품은 언제 설치할 수 있나요?</div>
                                      <div class="a">결제 완료일 기준으로 2일 내로 저희 쪽에서 고객님께 일정 확인 후 직접 방문하여 설치드리고 있습니다.</div>
                                      </div>

                          </li>
                                     <li class = "qa_li">

                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">스마트폰 연동이나 직접 데이터를 확인 할 수 있나요?</div>
                                      <div class="a">저희 모든 서비스는 스마트폰 연동이 가능하고 <strong>상단 메뉴탭 > My Page > IOT INFO</strong>를 통해 가입한 서비스의 데이터를 직접 눈으로 확인 가능합니다.</div>
                                      </div>

                          </li>
                                      <li class = "qa_li">
                                    
                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">스마트폰 연동은 어떻게 하나요?</div>
                                      <div class="a">제품 방문 설치시 방문 직원이 직접 자세하게 안내드리고 있습니다. 또는 <br /><strong>상단 메뉴탭 > NEWS</strong>에서 메뉴얼을 제공드리고 있으니 직접 설치하여 사용하실 수 있습니다.</div>
									</div>

                          </li>
                                     </ul>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="specialities" role="tabpanel" aria-labelledby="specialities-tab">
                            <div class="medilife-tab-content d-md-flex align-items-center">
                                <!-- 출장서비스 Tab Text  -->
                                <div class="medilife-tab-text">
                                   <ul class = "listWrap">
                                   <h3>출장서비스 FAQ</h3>
                                   <li class = "qa_li">

                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">출장서비스 신청은 어떻게 하나요?</div>
                                      <div class="a"><strong>상단 메뉴탭 > My Page > RESERVATION</strong>에서 신청 가능합니다.<br />
                                                  출장서비스는 평일 09:00~18:00, 30분 단위로 신청 할 수 있습니다.</div>
                                      </div>

                          </li>
                                     <li class = "qa_li">

                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">출장서비스 신청 내역은 어디서 확인 가능하나요?</div>
                                      <div class="a"><strong>상단 메뉴탭 > My Page > MY INFO > 예약 정보</strong>에서 확인 가능합니다.</div>
                                      </div>

                          </li>
                                      <li class = "qa_li">
                                    
                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">출장서비스 신청 날짜 및 시간을 변경할 수 있나요?</div>
                                      <div class="a">날짜/시간은 별도로 변경은 불가하며,<br /> 
                                                  <strong>상단 메뉴탭 > My Page > MY INFO > 예약 정보</strong>에서 취소 후 다시 신청하셔야 합니다.</div>
                                      </div>

                          </li>
                                     <li class = "qa_li">

                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">신청 한 출장서비스를 취소하고 싶습니다.</div>
                                      <div class="a"><strong>상단 메뉴탭 > My Page > MY INFO > 예약 정보 > 예약취소</strong>를 통해 취소 가능합니다.</div>
                                      </div>
                          </li>
                                     </ul>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="laboratory" role="tabpanel" aria-labelledby="laboratory-tab">
                            <div class="medilife-tab-content d-md-flex align-items-center">
                                <!-- 결제/취소/환불 Tab Text  -->
                                <div class="medilife-tab-text">
                                   <ul class = "listWrap">
                                   <h3>결제/취소/환불 FAQ</h3>
                                   <li class = "qa_li">

                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">사용할 수 있는 결제수단은 무엇인가요?</div>
                                      <div class="a">신용카드 및 간편결제(카카오페이, 네이버페이)로 상품을 구매하실 수 있습니다.</div>
                                      </div>

                          </li>
                                     <li class = "qa_li">

                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">제가 결제한 정보를 확인하고 싶습니다.</div>
                                      <div class="a"><strong>상단 메뉴탭 > My Page > MY INFO > 상품정보</strong>에서 확인하실 수 있습니다.</div>
                                      </div>

                          </li>
                                      <li class = "qa_li">
                                    
                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">요금제를 월 중간에 변경할 수 있나요? 변경할 경우 요금은 어떻게 적용되는건가요?</div>
                                      <div class="a">요금제는 월 중간에 변경 가능하며, 변경 원하실 경우 고객지원센터<br>[T.032-123-1234]로 연락주시면 자세한 안내 도와드리겠습니다.<br />
                                                  요금제를 변경한 날 전/후로 각각 날짜계산되어 다음달에 합산청구 또는 할인됩니다.</div>
                                      </div>

                          </li>
                                     <li class = "qa_li">

                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">서비스 구매 후 취소하고 싶습니다.</div>
                                      <div class="a"><strong>상단 메뉴탭 > My Page > MY INFO > 상품정보 > 결제취소</strong>버튼을 통해 취소 가능하며, 담당자 확인 후 환불까지는 영업일 기준 2~3일정도 소요될 수 있습니다.</div>
                                      </div>
                          </li>
                                     </ul>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="emergencies" role="tabpanel" aria-labelledby="emergencies-tab">
                            <div class="medilife-tab-content d-md-flex align-items-center">
                                <!-- 일반문의 Tab Text  -->
                                <div class="medilife-tab-text">
                                  <ul class = "listWrap">
                                  <h3>일반문의 FAQ</h3>
                                   <li class = "qa_li">

                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">고객지원센터 운영시간이 어떻게 되나요?</div>
                                      <div class="a">Fine-Apple 스마트홈의 고객지원센터 운영시간은 <br /><strong>평일(월요일~금요일) 09:00 ~18:00</strong>입니다.</div>
                                      </div>

                          </li>
                                     <li class = "qa_li">

                                    <div class="faq">
                                      <div class="q" onclick="$(this).next().toggle()">스마트홈 서비스와의 제휴 문의는 어떻게 하나요?</div>
                                      <div class="a">제휴 관련한 문의는 join_smarthome@fine-apple.com 로 메일 보내주시면 빠른 시간 내에 회신 드리겠습니다. </div>
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