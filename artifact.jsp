<!-- eform/artifact.jsp -->
<%@page contentType="text/html;charset=UTF-8"%>
<%@taglib uri="/tag/struts-bean" prefix="bean"%>
<%@taglib uri="/tag/struts-logic" prefix="logic"%>
<%@taglib uri="/tag/flowring" prefix="flowring"%>
<%@page import="com.flowring.WebSystem" %> <%-- AF-2429 --%>
<%@page import="si.wfinterface.WFCI" %> <%-- AF-2429 --%>
<%@page import="pe.pase.DBProcess" %> <%-- AF-2429 --%>
<%@page import="pe.pase.CSDBProcess" %> <%-- AF-2429 --%>
<%@page import="pe.pase.Task" %> <%-- AF-2429 --%>
<%@page import="pe.pase.IapTask" %> <%-- AF-2429 --%>
<%@page import="com.flowring.util.session.SessionUtil" %>
<jsp:useBean id="user" scope="session" type="com.flowring.struts.webapp.User"/>
<!-- 請注意!! 若增加工具列按鈕要特別測所有瀏覽器會不會引發 AF-3649類似問題, 解法可參考AF-3649 -->
<%
String type = "1";
%>
<!-- <link rel="stylesheet" type="text/css" href="css/jquery/plugin/FooTable/footable-0.1.css" />-->
<link rel="stylesheet" type="text/css" href="css/jquery/plugin/iCheck/square/blue.css" />
<!-- <link rel="stylesheet" type="text/css" href="css/jquery/plugin/iCheck/flat/blue.css"" />-->
<!-- <link rel="stylesheet" type="text/css" href="css/jquery/plugin/iCheck/polaris/polaris.css"" />-->
<!--<link rel="stylesheet" type="text/css" href="css/jquery/plugin/selectBox/jquery.selectBox.css?dummy=2" /> -->

<%--
<link rel="stylesheet" type="text/css" href="css/jquery/plugin/bootstrap/bootstrap.min.css" >
<link rel="stylesheet" type="text/css" href="css/jquery/plugin/bootstrap/bootstrap-theme.min.css" >
<link rel="stylesheet" type="text/css" href="css/jquery/plugin/bootstrap/docs.css" >
<link rel="stylesheet" type="text/css" href="css/jquery/plugin/bootstrap-select/bootstrap-select.css" />
<link type="text/css" rel="stylesheet" href="css/jquery/plugin/jquery-dropdown/jquery.dropdown.css" />
--%>
<!-- <script type="text/javascript" src="js/jquery/plugin/FooTable/footable.js"></script>-->
<script type="text/javascript" src="js/jquery/plugin/iCheck/jquery.icheck.js"></script>
<!-- <script type="text/javascript" src="js/jquery/plugin/selectBox/jquery.selectBox.js"></script> -->
<!-- <script type="text/javascript" src="js/jquery/plugin/sticky/jquery.sticky.js"></script>-->
<script type="text/javascript" src="js/jquery/plugin/sticky/waypoints.js"></script>
<script type="text/javascript" src="js/jquery/plugin/sticky/waypoints-sticky.js"></script>
<%--
<script type="text/javascript" src="js/jquery/plugin/jquery-dropdown/jquery.dropdown.js"></script>
<script type="text/javascript" src="js/jquery/plugin/sticky/jquery.sticky-kit.js"></script>
<script type="text/javascript" src="js/jquery/plugin/sticky/fixto.js"></script>
--%>

<%--
<script type="text/javascript" src="js/jquery/plugin/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="js/jquery/plugin/twitter-bootstrap-hover-dropdown/twitter-bootstrap-hover-dropdown.min.js"></script>
<script type="text/javascript" src="js/jquery/plugin/bootstrap-select/bootstrap-select.js"></script>
--%>

<jsp:useBean id="afsize" scope="request" type="pe.pde.AFSize"/>
<jsp:useBean id="param" scope="request" class="java.lang.String"/>
<jsp:useBean id="eform" scope="request" class="com.flowring.struts.webapp.eform.eformForm"/>
<jsp:useBean id="task" scope="request" type="si.wfcidata.AFTask"/>
<jsp:useBean id="paseconfig" scope="application" type="com.flowring.struts.webapp.SysConfig"/>    <%-- AEPP-962 --%>
<jsp:useBean id="FrontIapGoBackToAndReturnMode" scope="request" class="java.lang.String"/>
<jsp:useBean id="isFullForm" scope="request" class="java.lang.String"/><%-- AF-3335 add by Hank 20130627 --%>
<%-- <flowring:base/> --%>
<%
    WFCI wfci = WebSystem.getWFCI();
    Task frontTask = wfci.getTask(task.getFrontID());
    String frontProId = frontTask.getProcessID();
    
    //AF-3335 modify by Hank 20130624
    if (isFullForm.equals("") || isFullForm.equals("onlyFull")) {
        isFullForm = "true";
    }
    boolean readOnly = eform.isReadOnly();
%>

  <link rel="stylesheet" href="skins/default/css/main.css" type="text/css"/>
  <link rel="stylesheet" href="skins/default/css/aepp.css" type="text/css"/>
  <style type="text/css">
      
  <% if (SessionUtil.isValidEIPLicense(request.getSession())) {%> 
      #eformmenudiv {  /* in htmleformmenu.jsp */
          margin-left: 5px; 
          margin-top: 4px; 
          padding: 0px 2px; 
          width:99%; 
          min-width: 950px; 
          z-index: 999; 
          font-weight: normal;
      }

      /* css for waypoints-sticky.js  */
      #eformmenudiv.stuck {
          position:fixed;
          top: -4px;
          box-shadow:0 2px 4px rgba(0, 0, 0, .3);
          width: 99%;
          min-width: 950px;
          z-index: 999; 
      }
  <%} else { /* Agentflow module */ %>

      /* css for waypoints-sticky.js  */
      #eformmenudiv.stuck {
          position:fixed;
          top: 0;
          box-shadow:0 2px 4px rgba(0, 0, 0, .3);
          width: 96%;
          min-width: 950px;
          z-index: 999; 
      }
  <%}%>

  <% if (SessionUtil.isValidEIPLicense(request.getSession())) {%> 
      #signareadiv {
          <%if (SessionUtil.isRequestFromSlimPortalApp(session) && isFullForm.equals("false")) {//AF-4106 modify by Hank 20140522%>
          width: 97%; 
          <%} else {%>
          width: 100%; 
          <%}%>
          margin-left: 5px; 
          padding-top: 4px;
          z-index: 999;
          <%if (!SessionUtil.isRequestFromSlimPortalApp(session) && isFullForm.equals("true")) {//AF-4106 modify by Hank 20140522%>
          min-width: 950px;
          <%}%>
      }

      /* css for waypoints-sticky.js  */
      #signareadiv.stuck {
          position:fixed;
          top: 22px;
          width: 99%;
          min-width: 950px;
          /*box-shadow:0 2px 4px rgba(0, 0, 0, .3);*/
      }
  <%} else { /* Agentflow module */ %>
      #signareadiv {
          <%if (SessionUtil.isRequestFromSlimPortalApp(session) && isFullForm.equals("false")) {//AF-4106 modify by Hank 20140522%>
          width: 97%; 
          <%} else {%>
          width: 100%; 
          <%}%>
          padding-top: 4px;
          z-index: 999;
          <%if (!SessionUtil.isRequestFromSlimPortalApp(session) && isFullForm.equals("true")) {//AF-4106 modify by Hank 20140522%>
          min-width: 950px;
          <%}%>
      }

      /* css for waypoints-sticky.js  */
      #signareadiv.stuck {
          position:fixed;
          top: 22px;
          width: 96%;
          min-width: 950px;
          /*box-shadow:0 2px 4px rgba(0, 0, 0, .3);*/
      }
  <%}%>

      .artifactframe_wrapper {
          <%if (SessionUtil.isRequestFromSlimPortalApp(session) && isFullForm.equals("false")) {%>
          text-align: left;
          <%} else {%>
          text-align: center;
          <%}%>
      }
      
      .signareaContainer {
          width:100%;
          overflow: hidden;
          text-align: left;
          margin: 0 auto;
          padding-top: 2px;
          padding-right: 5px;
          padding-bottom: 10px;
          background: #E9E5DA;
      }

      .signareaContainer ul {
          list-style-type: none;
          padding-left: 5px;
          margin: 0px;
          height: 100%;
      }

      .signareaContainer li {
          /*display: inline-block;*/
          padding-top: 5px;
      }
      
      .signareaContainer-state {
          float: left;
          right: 10px;
          <%if (!SessionUtil.isRequestFromSlimPortalApp(session) && isFullForm.equals("true")) {//AF-4106 modify by Hank 20140522%>
          width: 380px;
          <%} else {%>
          width: 100%;
          min-width: 280px;
          <%}%>
          padding-left: 5px;
          padding-right: 20px;
          font-size: 1em;
      }
      
      .signareaContainer-state select {
          width: 250px; 
          margin-left: 3px; 
          margin-top: -10px;
          <%if (SessionUtil.isRequestFromSlimPortalApp(session) || !isFullForm.equals("true")) {//AF-4106 modify by Hank 20140522%>
          font-size: 0.8em;          
          <%}%>
      }

      .signareaContainer-comment {
          height: auto;
          float: left;
          right: 10px;
          <%if (!SessionUtil.isRequestFromSlimPortalApp(session) && isFullForm.equals("true")) {//AF-4106 modify by Hank 20140522%>
          width: 500px;
          <%} else {%>
          width: 100%;
          <%}%>
          padding-left: 5px;
      }
      
      .signareaContainer-comment select {
          <%if (SessionUtil.isRequestFromSlimPortalApp(session) || !isFullForm.equals("true")) {//AF-4106 modify by Hank 20140522%>
          font-size: 0.8em;          
          <%}%>
      }
      
      .signrecordlist {
          right: 10px;
          width: 100%;
          margin-left: 5px;
          text-align: left;
          padding-bottom: 5px;
      }

      <%if (!SessionUtil.isRequestFromSlimPortalApp(session) && isFullForm.equals("true")) {//AF-4106 modify by Hank 20140522%>
      .skin-section .sign_list li{
          position: relative;
          margin: 5px;
      }
      <%} else {%>
      .skin-section .sign_list li{
          position: relative;
          margin-top: 15px;
          margin-bottom: 15px;
      }
      <%}%>
      
      .signareaContainer-comment ul {
          margin:-5px;
      }
      
      <%if (!SessionUtil.isRequestFromSlimPortalApp(session) && isFullForm.equals("true")) {//AF-4106 modify by Hank 20140522%>
      .sign_textarea {
          height:70px; 
          width:450px;
          margin-top: -3px;
          margin-left: 1px;
      }
      <%} else {%>
      .sign_textarea {
          height:80px; 
          width: 95%; 
          max-width: 450px;   
          margin:5px 0;
          padding:3px;
          -webkit-box-sizing: border-box; /* <=iOS4, <= Android  2.3 */
             -moz-box-sizing: border-box; /* FF1+ */
                  box-sizing: border-box; /* Chrome, IE8, Opera, Safari 5.1*/
      }      
      <%}%>

      /* Automatically add "..." text extends certain width, but show it on hover. */
      .tip_ellipsis {
          <%if (!SessionUtil.isRequestFromSlimPortalApp(session) && isFullForm.equals("true")) {//AF-4106 modify by Hank 20140522%>
          width: 356px;
          text-overflow: ellipsis;
          white-space: nowrap;
          overflow: hidden;
          transition: max-width 500ms ease 0s;
          <%} else {%>
          padding-bottom:40px;
          padding-right:10px;
          <%}%>
      }
      .tip_ellipsis:hover {
          overflow: visible;
      }

      .ui-icon-expand { background-image: url(image/icon/plus.png) !important;}
      .ui-icon-signrecord { background-image: url(image/icon/signrecord.png) !important;}
      .ui-icon-print2 { background-image: url(image/icon/printer.png) !important;}
    
      <%if (!SessionUtil.isRequestFromSlimPortalApp(session) && isFullForm.equals("true")) {//AF-4106 modify by Hank 20140522%>
      .skin-icheck .skin-section .sign_list li,.skin-line .skin-section label{padding-left:30px; font-size:0.9em;}
      .mobile_font_size {font-size: 12px;}
      <%} else {%>
      .skin-icheck .skin-section .sign_list li,.skin-line .skin-section label{padding-left:30px; font-size:1.1em;}
      .mobile_font_size {font-size: 1.0em;}
      <%}%>
      
      /* override css/jquery/plugin/iCheck/square/blue.css */
      .iradio_square-blue{position:absolute;top:0px;left:0}
      /*.iradio_flat-blue{position:absolute;top:1px;left:0}*/
      /*.iradio_polaris{position:absolute;top:5px;left:0}*/
      
      .iCheckSaveMessage{float: left; margin-top: -17px;margin-left: 30px;}

      <!-- cs start -->
      <logic:notEqual name="paseconfig" property="showCSASAudit" value="true">    <%-- AF-2429 --%>
      tr.hidden_CS {display:none}
      </logic:notEqual>
      <logic:equal name="paseconfig" property="showCSASAudit" value="true">    <%-- AF-3029 add by Robert 20121218--%>        
      <%
      if (wfci.getDBProcess(task.getProcessID()) instanceof CSDBProcess) {
          CSDBProcess csProcess = (CSDBProcess) wfci.getDBProcess(task.getProcessID());
          if (csProcess != null && csProcess.isAllowShowCSArea() == false) {
      %>
      tr.hidden_CS {display:none}
      <%
          }
      }
      %>
      </logic:equal>
      
      <%-- AF-3943 add by Hank 20140306 --%>
      .auditLabel {
      <% if (request.getHeader("user-agent").indexOf("MSIE 6.0") != -1) { %>
          padding-left: 30px;
      <% } %>
      }
      <%-- AF-4106 add by Hank 20140522 --%>
      .allsignrecord {
          <%if (!SessionUtil.isRequestFromSlimPortalApp(session) && isFullForm.equals("true")) {%>
          margin-left: 3px; 
          padding-left: 3px;
       	  min-width: 950px;
       	  <%} else {%>
          width: 99%;
          <%} %>
      }
  </style>

<!--add by Change AF-3583-->
  <script type="text/javascript">

    var i18nConfirm = '<bean:message key="addas.submit"/>';
    var i18nCancel  = '<bean:message key="addas.cancel"/>';
  
    //add by Change AF-3649
    var isNonExitAction = false;
  
    window.onbeforeunload = function () {
        var artifactIframe = document.getElementById('artifact');
        var innerDoc = (artifactIframe.contentDocument) ? artifactIframe.contentDocument : artifactIframe.contentWindow.document;
        var dynamicForm = innerDoc.getElementById("DynamicForm");
        if (dynamicForm != null) {
	        var artInsID = dynamicForm.elements.ArtInsIDSYS.value;
	        
	        if (!(true == isNonExitAction)) {
	            jQuery.ajax ({
	                url: urlBase + "removeInsAttribute.do",
	                data: {"artInsID":artInsID},
	                type: "post",
	                dataType: "json",
	                async: false
	            });
	        }
        }
    }
    
    jQuery(document).ready(function() {

        //add by Change AF-3649
        jQuery(".funcion_bar_link").hover( 
            function(){isNonExitAction = true;},
            function(){isNonExitAction = false;}
        );
        jQuery("#print_signrecord_with_form").hover( 
                function(){isNonExitAction = true;},
                function(){isNonExitAction = false;}
            );
        jQuery("#print_signrecord").hover( 
                function(){isNonExitAction = true;},
                function(){isNonExitAction = false;}
            );

        jQuery('.signareaContainer-state input[type=radio]').iCheck({
            radioClass: 'iradio_square-blue'
        });
  
        //The jquery.icheck.js plugin will override the onclick event of radio button
        //so I have to code this function call.
        //
        //1. ProSign for prosignfunc.jsp
        jQuery('#proSignForm input[type=radio]').on('ifChecked', function(event) {
            var id = jQuery(this).attr('id');
            var radioBtnObj = document.getElementById(id);
            changeProSignType(radioBtnObj);
        });
        
        //2. Iap for iapfunc.jsp
        jQuery('#iapSignAuditForm input[type=radio]').on('ifChecked', function(event) {
            var id = jQuery(this).attr('id');
            var radioBtnObj = document.getElementById(id);
            changeIapSignType(radioBtnObj);
        });
        
        //3. AddAs for addasfunc.jsp
        jQuery('#signAuditFormId input[type=radio]').on('ifChecked', function(event) {
            var id = jQuery(this).attr('id');
            var radioBtnObj = document.getElementById(id);
            changeAddAsSignType(radioBtnObj);
        });

        //4. CS for csfunc.jsp
        jQuery('#csSignAuditFormId input[type=radio]').on('ifChecked', function(event) {
            var id = jQuery(this).attr('id');
            var radioBtnObj = document.getElementById(id);
            changeCSSignType(radioBtnObj);
        });

        /*
        jQuery(function() {
            ft = jQuery('.footable').footable();
        });
        jQuery('.footable tr').addClass('footable-detail-show');
        */
        jQuery('#artifact').load(function(){//AF-4355 added
            var width  = this.width;
            var height = this.height;
            var isFullForm = jQuery("#isFullForm").val();
            //console.log("isFullForm= " + isFullForm + ":w=" + width + ":h=" + height);
            if (isFullForm == "false") {
                //for mobile form
                width = "100%";
            }
            //alert("sw artifact load=" + isFullForm  +":"+ width+":"+ height);
            //console.log("artifact.jsp before call resize");
            reSize(isFullForm, width, height);
            //AF-6367
            <%
            //if (SessionUtil.isRequestFromSlimPortalApp(session)) {	//AF-6690
                if (SessionUtil.isMobileOn(session) && SessionUtil.isMobileRequest(session)) {//AF-4106 add by Hank 20140512
            %>
            var artifact = document.getElementById('artifact');
            clearTimeout(window.resizeEvt);
            window.resizeEvt = setTimeout(function()
            {
                //code to do after window is resized:
                //mobile phone switch orientation from portrait to landscape and vice versa.
                //The table using the dataTables plugin should be redrawn to make the table header display correctly.
                try {
                    //function is defined in mobileFormBody.jsp
                    var dataTables_scrollBody_count = artifact.contentWindow.document.getElementsByClassName("dataTables_scrollBody");
                   for (var i = 0; i < dataTables_scrollBody_count.length; i++) {
                        var headerHeight = jQuery(jQuery(dataTables_scrollBody_count[i]).parent().find(".dataTables_scrollHead")).height();
                        var bodyHeight = jQuery(dataTables_scrollBody_count[i]).css("height").replace("px", "");
                        jQuery(dataTables_scrollBody_count[i]).css("height", parseInt(bodyHeight - headerHeight) + "px");
                        bodyHeight = jQuery(dataTables_scrollBody_count[i]).css("height").replace("px", "");
                        var bodyTableHeight = jQuery(jQuery(dataTables_scrollBody_count[i]).find(".dataTable")).outerHeight();
                        if (bodyTableHeight < bodyHeight) {
                            jQuery(dataTables_scrollBody_count[i]).css("height", parseInt(bodyTableHeight) + "px");
                        }
                   }
                   artifact.contentWindow.reDrawEFormContainerSize();
               } catch (e) { /* ignored */ }
            }, 700);

           <%
             	}
            //}
            %>
            //AF-6367 end
        });

        //jQuery( "#configPrint2" ).menu();
        jQuery( "#configPrint").click(function() {
            //jQuery( "#printOptions" ).effect( "slide" );
            //jQuery( "#printOptions" ).toggle( "show" );
            //jQuery( "#printFormatHref" ).toggle( "show" );
            jQuery( "#printModeHref" ).toggle('drop' );
            
            return false;
        });

        <%if (!SessionUtil.isRequestFromSlimPortalApp(session)) {
        	if (!(SessionUtil.isMobileOn(session) && SessionUtil.isMobileRequest(session))) {//AF-4106 add by Hank 20140512
        %>
        /*
        jQuery("#eformmenudiv").sticky({topSpacing:-4});//Refer to htmleformmenu.jsp
        jQuery("#signareadiv").sticky({
            topSpacing:22,
            undocked_callback: undocked,
            redocked_callback: redocked
        });//Refer to addasfunc.jsp, prosignfunc.jsp, iapfunc.jsp, csfunc.jsp
        */
        
        jQuery("#eformmenudiv").waypoint('sticky');//Refer to htmleformmenu.jsp
        jQuery("#signareadiv").waypoint('sticky');//Refer to addasfunc.jsp, prosignfunc.jsp, iapfunc.jsp, csfunc.jsp
        
        jQuery("#signareadiv").waypoint(function(direction) {
            //console.log('Direction triggered scrolling ' + direction);
            if (direction == "down") {
                undocked();
            } else if (direction == "up") {
                redocked();
            }
        });
        
        jQuery(".signareaContainer .signarea_undock_btn").hide();
        jQuery(".signareaContainer .signarea_undock_btn").button({icons: {primary: "ui-icon-closethick"}}).click(function() {
            jQuery(".signareaContainer").slideUp('fast');
        });

        <% } else { //AF-4106 add by Hank 20140522 %>
        redocked();
        <% 
           }
        } else {//request from SlimPortal App 
        %>
        //AF-4002 Shihwei to adjust the iframe size for table in mobile view.
        jQuery(window).bind('resize', function(e)
        {
            window.resizeEvt;
            jQuery(window).resize(function()
            {
                var artifact = document.getElementById('artifact');
                clearTimeout(window.resizeEvt);
                window.resizeEvt = setTimeout(function()
                {
                    //code to do after window is resized: 
                    //mobile phone switch orientation from portrait to landscape and vice versa.
                    //The table using the dataTables plugin should be redrawn to make the table header display correctly.
                    try {
                        //function is defined in mobileFormBody.jsp
                        artifact.contentWindow.reDrawEFormContainerSize();
                    } catch (e) { /* ignored */ }
                }, 250);
            });
        });
        <%
        }
        %>
    });
    
    //Refer to addasfunc.jsp, prosignfunc.jsp, iapfunc.jsp, csfunc.jsp
    function undocked() {
        jQuery(".signareaContainer .signarea_undock_btn").show();
    }
    function redocked() {
        if (!jQuery(".signareaContainer").is(":visible")) {
            jQuery(".signareaContainer").show();
        }
        jQuery(".signareaContainer .signarea_undock_btn").hide();
    }
  </script>
<!--end AF-3583 -->

<div style="display:none;">
<form name="printModeSettings">
    <input type="hidden" id="PrintMode"           name="PrintMode"           value="<%=user.getMemberRecord().getConfig().getPrintMode()%>"/>
    <input type="hidden" id="PrintPage"           name="PrintPage"           value="<%=user.getMemberRecord().getConfig().getPrintPage()%>"/>
    <input type="hidden" id="PrintFooter"         name="PrintFooter"         value="<%=user.getMemberRecord().getConfig().getPrintFooter()%>"/>
    <input type="hidden" id="PrintAdjust"         name="PrintAdjust"         value="<%=user.getMemberRecord().getConfig().getAdjustPage()%>"/>
    <input type="hidden" id="HideBtnCmp"          name="HideBtnCmp"          value="<%=user.getMemberRecord().getConfig().isBtnCmpHidden()%>"/>
    <input type="hidden" id="PdfTextAntialiasOff" name="PdfTextAntialiasOff" value="<%=user.getMemberRecord().getConfig().isPdfTextAntialiasOff()%>"/><!-- ELITE-177 -->
    <input type="hidden" id="withSignRecords"     name="withSignRecords"     value="<%=user.getMemberRecord().getConfig().getWithSignRecords()%>"/><!-- 3.7 HotFix AF-3878 -->
</form>
</div>
<!-- add by wenchao AF-3581 -->
<logic:equal name="paseconfig" property="showSignResultOnBottomOfForm" value="true">
<div style="width: 99%; margin-left: 3px; padding-top: 4px;">
  <table border="0" cellspacing="0" cellpadding="0" width="100%">
    <tr>
      <td class="artifactframe_wrapper" width="100%" valign="top"><!-- artfact.jap -->
        <!-- AF-3060 modify by Hank 20130108 -->
        <input type="hidden" id="isFullForm" name="isFullForm" value="<%=isFullForm%>"/>
        <iframe id="artifact" name="artifact" type="content" src='<bean:write name="base"/><bean:write name="param" filter="false"/>' width='<bean:write name="afsize" property="width"/>' height='<bean:write name="afsize" property="height"/>' scrolling="no" style="border-width: 0;" frameborder="0"></iframe>
        <%--<iframe id="artifact" name="artifact" type="content" src='<bean:write name="base"/><bean:write name="param" filter="false"/>' onLoad="reSize(<%=isFullForm%>, <bean:write name="afsize" property="width"/>, <bean:write name="afsize" property="height"/>)" scrolling="no" style="border-width: 0;" frameborder="0"></iframe>--%>
      </td>
    </tr>
  </table>
</div>
</logic:equal>
<!-- end by wenchao AF-3581 -->
<%--
<table border="0" cellspacing="0" cellpadding="0" width="100%">
  <tr bgcolor="#666666" height="1">
    <td width="3" colspan="13"/>
  </tr>
</table>
--%>

<div id="signareadiv">
<table border="0" cellspacing="0" cellpadding="0" width="100%">
  <logic:equal name="FrontIapGoBackToAndReturnMode" value="true">
  <tr>
    <td align="left" width="100%" class="oasis_setup_text_bold">
      <font color="RED"><bean:message key="iap.ignoreRoutingTips"/></font>
    </td>
  </tr>
  </logic:equal>

  <!-- add for IapTask -->
  <logic:equal name="eform" property="iapFunc" value="true">
  <tr>
    <td align="center" width="100%">
      <jsp:include page="/IAPFunc.do?formStyle=html">
        <jsp:param name="readOnly" value="<%=readOnly %>" />
      </jsp:include>
    </td>
  </tr>
  </logic:equal>

  <!-- prosign start AF-2859 -->
  <logic:equal name="eform" property="signFunc" value="true">
  <tr>
    <td align="center" width="100%">
      <jsp:include page="/AddASFunc.do?formStyle=html">
        <jsp:param name="readOnly" value="<%=readOnly %>" />
      </jsp:include>
    </td>
  </tr>
  </logic:equal>
  <logic:equal name="eform" property="addAudit" value="false">
  <logic:equal name="eform" property="proSignFunc" value="true">
  <tr>
    <td align="center" width="100%">
      <jsp:include page="/ProSignFunc.do?formStyle=html">
        <jsp:param name="readOnly" value="<%=readOnly %>" />
      </jsp:include>
    </td>
  </tr>
  </logic:equal>
  </logic:equal>
  <!-- prosign end -->

  <!-- cs start -->
  <logic:notEqual name="paseconfig" property="showCSASAudit" value="true">    <%-- AF-2429 --%>
  <style type="text/css">
    tr.hidden_CS {display:none}
  </style>
  </logic:notEqual>
  <logic:equal name="paseconfig" property="showCSASAudit" value="true">    <%-- AF-3029 add by Robert 20121218--%>        
  <%
  if (wfci.getDBProcess(task.getProcessID()) instanceof CSDBProcess) {
      CSDBProcess csProcess = (CSDBProcess) wfci.getDBProcess(task.getProcessID());
      if (csProcess != null && csProcess.isAllowShowCSArea() == false) {
  %>
  <style type="text/css">
    tr.hidden_CS {display:none}
  </style>
  <%
      }
  }
  %>
  </logic:equal>
  <tr class="hidden_CS">
    <td align="center" width="100%">
      <jsp:include page="/CSFunc.do?formStyle=html" >
        <jsp:param name="readOnly" value="<%=readOnly %>" />
      </jsp:include>
    </td>
  </tr>
  <!-- cs end -->
  
  <tr height="4" >
    <td height="4" >
      <!-- divider -->
    </td>
  </tr> 
</table>
</div><!-- end of signareadiv div -->
<logic:present name="showSignArea">
<logic:equal name="showSignArea" value="true">
<div id="allsignrecordDiv" class="allsignrecord"><%-- AF-4106 modify by Hank 20140522 --%>
<%--<table border="0" cellspacing="0" cellpadding="0" width="100%"> --%>
  <!-- add by wenchao AF-3581 -->
  <%@ include file="allSignResult.jsp"%>
  <!-- end add by wenchao AF-3581--> 
<%--</table> --%>
</div><!-- end of allsignrecordDiv -->
</logic:equal>
</logic:present>
<logic:equal name="paseconfig" property="showSignResultOnBottomOfForm" value="false">
<div style="width: 98%; margin-left: 3px; padding-top: 4px;">
  <table border="0" cellspacing="0" cellpadding="0" width="100%">
    <tr>
      <td class="artifactframe_wrapper" width="100%" valign="top"><!-- artfact.jap -->
        <!-- AF-3060 modify by Hank 20130108 -->
        <input type="hidden" id="isFullForm" name="isFullForm" value="<%=isFullForm%>"/>
        <iframe id="artifact" name="artifact" type="content" src='<bean:write name="base"/><bean:write name="param" filter="false"/>' width='<bean:write name="afsize" property="width"/>' height='<bean:write name="afsize" property="height"/>' scrolling="no"  style="border-width: 0;" frameborder="0"></iframe>
        <%--<iframe id="artifact" name="artifact" type="content" src='<bean:write name="base"/><bean:write name="param" filter="false"/>' onLoad="reSize(<%=isFullForm%>, <bean:write name="afsize" property="width"/>, <bean:write name="afsize" property="height"/>)" scrolling="no" style="border-width: 0;" frameborder="0"></iframe>--%>
      </td>
    </tr>
  </table>
</div>
</logic:equal>
<!-- add by yhtseng, 2004/01/13 -->
<iframe id="hiddenframe" name="hiddenframe" src="" width="0" height="0" scrolling="no" style="border-width: 0;"></iframe>
<!-- end add by yhtseng -->

<!-- AF-3060 add by Hank 20130108 -->
<script type="text/javascript">
    // add by AF-4050
    function reHeadWidthSize(totalWidth) {
        var windowWidth = jQuery(window).width();
        if (totalWidth.indexOf('px') != -1) {
            totalWidth = totalWidth.substring(0, totalWidth.indexOf('px'));
        }
        totalWidth = parseInt(totalWidth);
        windowWidth = parseInt(windowWidth);
        if (totalWidth > 1024 && totalWidth > windowWidth) {
            jQuery('#navi').css('width', totalWidth + 'px');
            jQuery('.sticky-wrapper').css('width', totalWidth + 'px');
            jQuery('#maxPageHeight').css('width', totalWidth + 'px');
            jQuery('#header').css('width', totalWidth + 'px');
        } else if (totalWidth > 1024 && totalWidth <= windowWidth || totalWidth <= 1024) {
            jQuery('#navi').css('width', '100%');
            jQuery('.sticky-wrapper').css('width', '100%');
            jQuery('#maxPageHeight').css('width', '100%');
            jQuery('#header').css('width', '100%');
        }
    }

    function rePagebodyWidthSize(totalWidth) {
        var windowWidth = jQuery(window).width();
        if (totalWidth.indexOf('px') != -1) {
            totalWidth = totalWidth.substring(0, totalWidth.indexOf('px'));
        }
        totalWidth = parseInt(totalWidth);
        windowWidth = parseInt(windowWidth);
        if (totalWidth > 1024 && totalWidth > windowWidth) {
            jQuery('.pagebody').css('width', totalWidth + 'px');
        } else if (totalWidth > 1024 && totalWidth <= windowWidth || totalWidth <= 1024) {
            jQuery('.pagebody').css('width', '100%');
        }
    }
    function reSize(isFullForm, width, height) {
        //console.log("artifact.jsp do resize #1");
        var artifact = document.getElementById('artifact');
        var cssignarea = document.getElementById("cssignarea");
        if (isFullForm == "true") {
            //console.log("ssss2" + new Date() + ":" + artifact.width + ":" + width + ":" + artifact.height + ":" + height);
            artifact.width = width;
            artifact.height = height;
            <%
            if (!SessionUtil.isRequestFromSlimPortalApp(session)) { 
              boolean isEIP = SessionUtil.isValidEIPLicense(request.getSession());
              if (isEIP) {
            %>
            reHeadWidthSize(artifact.width);
            <%
                if (request.getHeader("User-Agent").indexOf("MSIE 8.0") != -1) {
            %>
            rePagebodyWidthSize(artifact.width);
            <%
                }//end of MEIS 8.0
              }// end of isEIP 
            }// end of !SlimPortal Request %>
            <%
            //AF-4106 add by Hank 20140522
            if (!SessionUtil.isRequestFromSlimPortalApp(session)) { 
              if (SessionUtil.isMobileOn(session) && SessionUtil.isMobileRequest(session) && isFullForm.equals("true")) {
            %>
            jQuery('.allsignrecord').css('min-width', width);
            jQuery('#signareadiv').css('min-width', width);
            jQuery('#signareadiv.stuck').css('min-width', width);
            jQuery('div#GradientLayout_m').css('min-width', width);
            jQuery('div#GradientLayoutBottom_m').css('min-width', width);
            <% 
              }
            }
            %>
        } else {
            var width = (window.innerWidth > 0) ? window.innerWidth : screen.width;//get the device width
            //console.log("artifact.jsp do resize #2= window.innerWidth = " + window.innerWidth + ":" + screen.width);
            artifact.width = width - 5;//AF-3521 modify by Hank 20130909, AF-4002 Shihwei 2014-10-22
            artifact.height = artifact.contentWindow.document.body.offsetHeight + 8;//AF-3579 modify by Hank 20140318, AF-6362 modify by Kuang 
            <%if (!SessionUtil.isRequestFromSlimPortalApp(session)) {%>
            //artifact.contentWindow.reDrawTable();
            //console.log("artifact.jsp do resize #3");
            <%} else {//request from SlimPortal App %>
            clearTimeout(window.resizeEvt);
            window.resizeEvt = setTimeout(function()
            {
                //code to do after artifact is resized
                try {
                    //function is defined in mobileFormBody.jsp
                    artifact.contentWindow.reDrawEFormContainerSize();        
                } catch (e) { /* ignored */ }
            }, 250);

            <%}%>
            /*
            if (cssignarea != undefined) {
                jQuery("#cssignarea").css("min-width", artifact.contentWindow.document.body.scrollHeight + 30);
            }
            */
        }
    }
    //AF-4002 called from mobileFormBody.jsp
    function reSizeAfterReDrawEFormContainerSize() {
        var artifact = document.getElementById('artifact');
        artifact.height = artifact.contentWindow.document.body.scrollHeight;
        
        //same code in mobileFormBody.js
        var width = screen.width;//get the device width
        if (window.orientation != 'undefined') {
            var iRotate = window.orientation;//Android always 0
            var iOS = ( navigator.userAgent.match(/(iPad|iPhone|iPod)/g) ? true : false );
            if (iRotate == 90|| iRotate == -90) {
                //landscape
                //the window.orientation property to figure out which way the device is oriented. 
                //With Android phones, screen.width or screen.height also updates as the device is rotated. 
                //this is not the case with the iOS
                if (iOS) {
                    //width = (window.innerHeight > 0) ? window.innerHeight : screen.height;//get the device width
                    width = screen.height;//get the device width
                }
            } else {/* 0 or 180 portrait */}
        }
        artifact.width = width - 5;//AF-4002 Shihwei 2014-10-22
        //console.log("artifact.width=" + artifact.width);
        //alert("sw + artifact.jsp artifact.height=" + artifact.height);
    }
</script>
<script src="eform/artifact.ask.min.js?v=20230829"></script>