/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.62
 * Generated at: 2022-05-06 02:39:04 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.board;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import board.*;

public final class boardUpdateForm_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_packages.add("board");
    _jspx_imports_classes = null;
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    if (!javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSP들은 오직 GET, POST 또는 HEAD 메소드만을 허용합니다. Jasper는 OPTIONS 메소드 또한 허용합니다.");
        return;
      }
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta charset=\"UTF-8\">\r\n");
      out.write("<title>글 수정 폼</title>\r\n");
      out.write("<style>\r\n");
      out.write("@import\r\n");
      out.write("	url('https://fonts.googleapis.com/css2?family=Paytone+One&display=swap');\r\n");
      out.write("\r\n");
      out.write("@import\r\n");
      out.write("	url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');\r\n");
      out.write("\r\n");
      out.write("#container {\r\n");
      out.write("	width: 500px;\r\n");
      out.write("	margin: 0 auto;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("a {\r\n");
      out.write("	text-decoration: none;\r\n");
      out.write("	color: black;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("/* 상단 - 메인, 서브 타이틀 */\r\n");
      out.write("\r\n");
      out.write(".m_title {\r\n");
      out.write("	font-family: 'Paytone One', sans-serif;\r\n");
      out.write("	font-size: 3em;\r\n");
      out.write("	text-align: center;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".s_title {\r\n");
      out.write("	font-family: 'Do Hyeon', sans-serif;\r\n");
      out.write("	font-size: 2em;\r\n");
      out.write("	text-align: center;\r\n");
      out.write("	margint-bottom: 80px;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("	\r\n");
      out.write("/* 본문 - 테이블 */\r\n");
      out.write("\r\n");
      out.write("table {\r\n");
      out.write("	width: 100%;\r\n");
      out.write("	border: 1px solid black;\r\n");
      out.write("	border-collapse: collapse;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("tr {\r\n");
      out.write("	height: 50px;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("td, th {\r\n");
      out.write("	border: 1px solid black;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("th {\r\n");
      out.write("	background: #ced4da;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("td {\r\n");
      out.write("	padding-left: 5px;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("#subject {\r\n");
      out.write("	height: 23px;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".c_text {\r\n");
      out.write("	padding: 5px 0 5px 5px;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("/* 하단 - 버튼 */\r\n");
      out.write(".btns {\r\n");
      out.write("	text-align: center;\r\n");
      out.write("	margin-top: 20px;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".btns input {\r\n");
      out.write("	width: 100px;\r\n");
      out.write("	height: 35px;\r\n");
      out.write("	border: none;\r\n");
      out.write("	background: black;\r\n");
      out.write("	color: white;\r\n");
      out.write("	cursor: pointer;\r\n");
      out.write("	transition: .3s;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".btns input:hover {\r\n");
      out.write("	background: white;\r\n");
      out.write("	border: 1px solid gray;\r\n");
      out.write("	color: black;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</style>\r\n");
      out.write("\r\n");
      out.write("<script>\r\n");
      out.write("	document.addEventListener(\"DOMContentLoaded\", function() {\r\n");
      out.write("		let form = document.updateForm;\r\n");
      out.write("		let btn_update = document.getElementById(\"btn_update\");\r\n");
      out.write("		\r\n");
      out.write("		// 글 등록 버튼을 클릭할 때\r\n");
      out.write("		btn_update.addEventListener(\"click\", function() {\r\n");
      out.write("			if (!form.subject.value) {\r\n");
      out.write("				// 제목 입력 안했을 때\r\n");
      out.write("				alert(\"제목을 입력하시오.\");\r\n");
      out.write("				form.subject.focus();\r\n");
      out.write("				return;\r\n");
      out.write("			}\r\n");
      out.write("			\r\n");
      out.write("			if (!form.content.value) {\r\n");
      out.write("				// 글 내용 입력 안했을 때\r\n");
      out.write("				alert(\"내용을 입력하시오.\");\r\n");
      out.write("				form.content.focus();\r\n");
      out.write("				return;\r\n");
      out.write("			}\r\n");
      out.write("			form.submit();\r\n");
      out.write("		})\r\n");
      out.write("		\r\n");
      out.write("		\r\n");
      out.write("		// 전체 게시글 버튼을 클릭할 때\r\n");
      out.write("		let btn_boardList = document.getElementById(\"btn_boardList\");\r\n");
      out.write("		btn_boardList.addEventListener(\"click\", function() {\r\n");
      out.write("			location = 'boardList.jsp';\r\n");
      out.write("		})\r\n");
      out.write("	})\r\n");
      out.write("	\r\n");
      out.write("	\r\n");
      out.write("	\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");

String memberId = (String)session.getAttribute("memberId");

if (memberId == null) {
	out.print("<script>location = '../logon/memberLoginForm.jsp';</script>");
}

int num = Integer.parseInt(request.getParameter("num"));

BoardDAO boardDAO = BoardDAO.getInstance();
BoardDTO board = boardDAO.getBoardUpdateForm(num);


      out.write("\r\n");
      out.write("	\r\n");
      out.write("	<div id=\"container\">\r\n");
      out.write("	\r\n");
      out.write("		<div class=\"m_title\">\r\n");
      out.write("			<a href=\"boardList.jsp\">EZEN MALL</a>\r\n");
      out.write("		</div>\r\n");
      out.write("		<div class=\"s_title\">글 수정</div>\r\n");
      out.write("		\r\n");
      out.write("		<form action=\"boardUpdatePro.jsp\" method=\"post\" name=\"updateForm\">\r\n");
      out.write("			<input type=\"hidden\" name=\"num\" value=\"");
      out.print(num);
      out.write("\">\r\n");
      out.write("			<table>\r\n");
      out.write("				<tr>\r\n");
      out.write("					<th width=\"15%\">작성자</th>\r\n");
      out.write("					<td width=\"85%\">\r\n");
      out.write("						<span class=\"c_id\">");
      out.print(memberId );
      out.write("</span>\r\n");
      out.write("					</td>\r\n");
      out.write("				</tr>\r\n");
      out.write("				<tr>\r\n");
      out.write("					<th>제목</th>\r\n");
      out.write("					<td><input type=\"text\" name=\"subject\" id=\"subject\" size=\"54\" value=\"");
      out.print(board.getSubject() );
      out.write("\"></td>\r\n");
      out.write("				</tr>\r\n");
      out.write("				<tr>\r\n");
      out.write("					<th>내용</th>\r\n");
      out.write("					<td><textarea rows=\"25\" cols=\"56\" name=\"content\" id=\"content\" class=\"c_text\">");
      out.print(board.getContent() );
      out.write("</textarea> </td>\r\n");
      out.write("				</tr>\r\n");
      out.write("			\r\n");
      out.write("			</table>\r\n");
      out.write("			<div class=\"btns\">\r\n");
      out.write("				<input type=\"button\" value=\"글 수정\" id=\"btn_update\">&emsp;&emsp;\r\n");
      out.write("				<input type=\"button\" value=\"게시글 보기\" id=\"btn_boardList\">\r\n");
      out.write("			</div>\r\n");
      out.write("		\r\n");
      out.write("		</form>\r\n");
      out.write("	\r\n");
      out.write("	</div>\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}