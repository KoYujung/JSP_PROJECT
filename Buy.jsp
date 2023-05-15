<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>��û�� �ۼ�</title>
    <link rel="stylesheet" href="MyPage.css">
</head>
<body>
  <header>
    <nav>
      <a href="#" id="mark"><img src="mark.png" width="50"></a>
      <div id="login">
        <a href="#">�α���</a>
        <a href="#">ȸ������</a>
      </div>
      <div id="logo">
        <a href="#"><img src="logo.png" width="180"></a>
      </div>
      <div id="navbar">
        <ul>
          <li><a href="Test.html">Ȩ</a></li>
          <li>
            <div class="dropdown">
              <a class="dropbtn">å �Ǹ�</a>
              <div class="dropdown-content">
                <a href="Sell.html">�� �ۼ�</a>
                <a href="Sell_detail.html">å ���</a>
              </div>
            </div>
          </li>
          <li>
            <div class="dropdown">
              <p class="dropbtn">å ��û</p>
              <div class="dropdown-content">
                <a href="Buy.jsp">�� �ۼ�</a>
                <a href="Buy_detail.html">å ���</a>
              </div>
            </div>
          </li>
          <li><a href="MyPage.html">����������</a></li>
        </ul>
      </div>
    </nav>
  </header>
    <main>
        <form action="#" method="post" enctype="multipart/form-data">
            <table cellpadding="20px" cellspacing="10px">
                <tr>
                    <td>ī�װ�</td>
                    <td>
                        <select>
                          <option value="lang">���</option>
                          <option value="econ">����</option>
                          <option value="comp">��ǻ��</option>
                          <option value="art">����</option>
                          <option value="reli">����</option>
                      </select>
                    </td>
                </tr>
                <tr>
                    <td><label>���� �̸�</label></td>
                    <td><input type="text" id="sName" name="sName" placeholder="å �̸�"></td>
                </tr>
                <tr>
                    <td><label>����</label></td>
                    <td><input type="text" id="sAuth" name="sAuth" placeholder="����"></td>
                </tr>
                <tr>
                    <td><label>���ǻ�</label></td>
                    <td><input type="text" id="sPub" name="sPub" placeholder="���ǻ�"></td>
                </tr>
                <tr>
                    <td><label>�����</label></td>
                    <td><input type="number" id="sHope" name="sHope" placeholder="�����"></td>
                </tr>
            </table>
            <hr width="70%">
            <input type="reset" value="���" class="regButton">&nbsp;&nbsp;&nbsp;
            <input type="submit" value="���" class="regButton">
        </form>
    </main>
    <footer>
    </footer>
  </body>
</html>