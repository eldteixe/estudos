<!--#INCLUDE FILE ="chamar_banco.asp"-->
<!--#INCLUDE FILE ="funcao_senha.asp"-->
<!--#INCLUDE FILE ="CPF_CNPJ.asp"-->
<!--#include file="aDOVBS.inc" -->
<%
pesquisa=replace(trim(request("pesquisa")),"'","")
pagina=request("pagina") 
codigo=request("codigo")
opcao=request("opcao")
box=request("deletar")
ordem=request("ordem")
ordem2=request("ordem2")
if box <> "" then
   conn.Execute ("update contrato set status=1 where codigo IN ("&box&")")
end if
currentPage = Request( "currentPage" )
Set contador = Server.CreateObject( "ADODB.Recordset" )
contador.activeConnection = conn
contador.CursorType = adOpenStatic
IF currentPage = "" THEN currentPage = 1
Set itens = Server.CreateObject( "ADODB.Recordset" ) 
itens.activeConnection = conn
itens.CursorType = adOpenStatic  
itens.PageSize = 3
if ordem="" then
   ordem="contrato.numero"
end if
if pesquisa<>"" then
   if opcao="1" then
      sql="and contrato.numero like '%"&pesquisa&"%' "
   else
      sql="and imoveis.descricao like '%"&pesquisa&"%' "
   end if
end if
itens.Open "SELECT contrato.*, contrato.codigo AS codigo, contrato.data_vencimento as vencimento, contrato.numero AS numero, imoveis.descricao AS imovel, clientes.nome AS nome, servico.descricao AS servico, contrato.status AS status FROM (((contrato INNER JOIN clientes ON contrato.cod_cliente = clientes.codigo) INNER JOIN imoveis ON contrato.cod_imovel = imoveis.codigo) INNER JOIN servico ON contrato.tipo_servico = servico.codigo) where contrato.cod_cliente="&codigo&" and contrato.status=0 "&sql&" ORDER BY "&ordem&" "&ordem2,conn%>
<html>
<head>
<title>:::::Imobi....:::</title>
<script language="javascript" src="formatacao.js"></script>
<link rel="stylesheet" href="estilo.css" type="text/css">
<meta name="description" content="BIG SOLUTIONS TECNOLOGIA DA INFORMA��O LTDA">
</head>
<body marginheight="0" marginwidth="0" leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#333333" link="#333333" vlink="#333333" alink="#333333">
<table border="0" width="777" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <!--#INCLUDE FILE ="Main_Topo.asp"-->
          <%set clientes  = conn.execute("select * from clientes where codigo="&codigo)%>
          <table><tr><td></td></tr></table>
          <table width=100% bgcolor=#CCCCCC>
            <tr><td></td></tr>
          </table>
          <table width=100% border=0 bgcolor=#E8E8E8 cellspacing="0" cellpadding="0">
            <tr> 
              <td width=20><img src="../img/r_8.gif"></td>
              <td class="tb">
                   <B>DETALHE CLIENTE</B>
              </td>
              <td class="tb" align=right><a href="Imprimir_contrato_cliente.asp?codigo=<%=codigo%>&pagina=detalhe_cliente"><img alt="Imprimir Cliente" src="../img/icone-imprimir.gif" border=0></a></td>
            </tr>
          </table>
          <table><tr height=10><td></td></tr></table>
          <table width=100% border=0 cellspacing="0" cellpadding="0">
            <tr>
              <td class="tb" width=60><b>&nbsp;NOME:</b></td>
              <td class="tb" colspan=3><%=clientes("nome")%></td>
            </tr>
            <tr>
              <td class="tb" width=60><b>&nbsp;ENDERE�O:</b></td>
              <td class="tb" colspan=3><%=clientes("endereco")%>&nbsp;-&nbsp; <%=clientes("numero")%> &nbsp;-&nbsp;<%=clientes("complemento")%></td>
            </tr>
            <tr>
              <td class="tb" width=60><b>&nbsp;BAIRRO:</b></td>
              <td class="tb"><%=clientes("bairro")%></td>
              <td class="tb" width=60><b>&nbsp;CIDADE:</b></td>
              <td class="tb"><%=clientes("cidade")%></td>
            </tr>
            <tr>
              <td class="tb" width=60><b>&nbsp;ESTADO:</b></td>
              <td class="tb"><%=clientes("estado")%></td>
              <td class="tb" width=60><b>&nbsp;CEP:</b></td>
              <td class="tb"><%=clientes("cep")%></td>
            </tr>
            <tr>
              <td class="tb" width=60><b>&nbsp;TELEFONE:</b></td>
              <td class="tb">(<%=clientes("ddd_fone")%>)<%=clientes("fone")%></td>
              <td class="tb" width=60><b>&nbsp;CELULAR:</b></td>
              <td class="tb">(<%=clientes("ddd_cel")%>)<%=clientes("celular")%></td>
            </tr>
            <tr>
              <td class="tb" width=60><b>&nbsp;CPF:</b></td>
              <td class="tb"><%=clientes("cpf")%></td>
              <td class="tb" width=60><b>&nbsp;RG:</b></td>
              <td class="tb"><%=clientes("identidade")%></td>
            </tr>
            <tr>
              <td class="tb" width=60><b>&nbsp;E-MAIL:</b></td>
              <td class="tb" colspan=3><%=clientes("email")%></td>
            </tr>
            <tr>
              <td class="tb" width=60><b>&nbsp;BANCO:</b></td>
              <td class="tb">
                <%set bancos=conn.execute("select * from bancos where codigo="&clientes("cod_banco"))%>
                <%=bancos("descricao")%>
              </td>
              <td class="tb" width=60><b>&nbsp;AG�NCIA:</b></td>
              <td class="tb"><%=clientes("agencia")%></td>
            </tr>
            <tr>
              <td class="tb" width=60><b>&nbsp;CONTA:</b></td>
              <td class="tb"><%=clientes("conta")%></td>
              <td class="tb" width=60><b>&nbsp;RENDA:</b></td>
              <td class="tb">R$ <%=formatnumber(clientes("renda"),2)%></td>
            </tr>
            <tr>
              <td class="tb" width=60><b>&nbsp;PROFISS�O:</b></td>
              <td class="tb"><%=clientes("profissao")%></td>
              <td class="tb" width=105><b>&nbsp;DATA INCLUS�O:</b></td>
              <td class="tb"><%=clientes("data_inclusao")%></td>
            </tr>
          </table>
          <table><tr><td></td></tr></table>
          <table width=100% bgcolor=#CCCCCC>
            <form method=post action="<%=request.servervariables("SCRIPT_NAME")%>?currentPage=<%=currentPage%>&codigo=<%=codigo%>"name="form1">
            <tr><td></td></tr>
          </table>
          <table width=100% border=0 bgcolor=#E8E8E8 cellspacing="0" cellpadding="0">
            <tr> 
              <td width=20><img src="../img/r_16.gif"></td>
              <td class="tb"><B>CONTRATOS DO CLIENTE</B></td>
            </tr>
          </table>  
          <table width=100%
            <tr height=25><td></td></tr>
            <tr>
              <td width=10><img src="../img/icon_mini_search.gif"></td>
              <td valign=top><input type=text name="pesquisa" value="<%=pesquisa%>" style="width:190; height:17; background=#E8E8E8;"></td>
              <td valign=top>
                <%if opcao="" or opcao="1" then%>
                   <input type=radio name="opcao" value=1 checked>N�mero
                <%else%>
                   <input type=radio name="opcao" value=1>N�mero
                <%end if%>
              </td>
              <td valign=top>
                <%if opcao="2" then%>
                   <input type=radio name="opcao" value=2 checked>Im�vel
                <%else%>
                   <input type=radio name="opcao" value=2>Im�vel
                <%end if%>
              </td>
              <td><input type=image src="../img/pop_ok.gif" alt="Resultado"></td>
              <td><a href="Main_filtro_contrato.asp"><img alt="Filtrar Contratos" src="../img/filtro.gif" border=0></a></td>
              <td><a href="Imprimir_contrato.asp?currentPage=<%=currentPage%>&ordem=<%=ordem%>&ordem2=<%=ordem2%>&pesquisa=<%=pesquisa%>&opcao=<%=opcao%>&pagina=Detalhe_cliente&codigo2=<%=codigo%>"><img alt="Imprimir Contratos" src="../img/icone-imprimir.gif" border=0></a></td>
            </tr>
            <tr height=5><td></td></tr>
          </table>
          <table width=100%>
            <tr>
              <td bgcolor=#B0B0B0 width=20><input type="checkbox" name="selecionar" onclick="todos()"></td>
              <td align=center bgcolor=#B0B0B0><font color=#FFFFFF><b>Contrato</b></td>
              <td width=105 bgcolor=#B0B0B0><font color=#FFFFFF><b>Im�vel</b></td>
              <td align=center width=100 bgcolor=#B0B0B0><font color=#FFFFFF><b>Servi�o</b></td>
              <td align=center width=100 bgcolor=#B0B0B0><font color=#FFFFFF><b>Data de Vencimento</b></td>
              <td align=center width=105 bgcolor=#B0B0B0><font color=#FFFFFF><b>A��es</b>
            </tr>
            <%If itens.EOF = true then%>
               <tr>
                 <td bgcolor=#D8DCD8></td>
                 <td bgcolor=#D8DCD8></td>
                 <td bgcolor=#D8DCD8>N�o h� Registros cadastrados.</td>
                 <td bgcolor=#D8DCD8></td>
                 <td bgcolor=#D8DCD8></td>
                 <td bgcolor=#D8DCD8></td>
               </tr>  
            <%else
               itens.absolutePage = cINT(currentPage)
               do While Not itens.EOF and cont<itens.PageSize
                  if cor="DADAB5" then
                     cor="F4F2EA"
                  else
                     cor="DADAB5"
                  end if%> 
                  <tr>
                    <td bgcolor=<%=cor%> width=20><input type=checkbox  name="deletar" value="<%=itens("codigo")%>"></td>
                    <td class="tb" align=center bgcolor=<%=cor%>><a href="Detalhe_contrato.asp?codigo=<%=itens("codigo")%>&pagina=detalhe_cliente&codigo2=<%=codigo%>"><%=itens("numero")%></a></td>
                    <td class="tb" align=left bgcolor=<%=cor%>><%=itens("imovel")%></td>
                    <td class="tb" align=center bgcolor=<%=cor%>><%=itens("servico")%></td>
                    <td class="tb" align=center bgcolor=<%=cor%>><%=itens("vencimento")%></td>
                    <td bgcolor=<%=cor%> align=center>
                      <a href="javascript:confirma('<%=request.servervariables("SCRIPT_NaME")%>?currentPage=<%=currentpage%>&ordem=<%=ordem%>&ordem2=<%=ordem2%>&deletar=<%=itens("codigo")%>&pesquisa=<%=pesquisa%>&opcao=<%=opcao%>&codigo=<%=codigo%>')"><img src="../img/excluir_n.gif" alt="Excluir" border=0></a>
                      <a href="Alt_contrato.asp?codigo=<%=itens("codigo")%>&codigo2=<%=codigo%>&pagina=Detalhe_cliente"><img src="../img/editar.gif" alt="Editar" border=0></a>
                      <%set rescisao=conn.execute("select * from recisao where cod_contrato="&itens("codigo")) %>
                      <%if rescisao.eof then%>
                        <a href="Cad_Rescisao.asp?codigo=<%=itens("codigo")%>&codigo2=<%=codigo%>&pagina=Detalhe_Cliente"><img src="../img/recisao.gif" alt="Rescindir" border=0></a>
                      <%else%>
                        <a href="Alt_Rescisao.asp?codigo=<%=itens("codigo")%>&codigo2=<%=codigo%>&pagina=Detalhe_Cliente"><img src="../img/recisao.gif" alt="Rescindir" border=0></a>
                      <%end if%>
                      <%set comissao=conn.execute("select * from contas where cod_contrato="&itens("codigo")&" and cod_funcionario="&itens("cod_corretor"))%>
                      <%if comissao.eof then%>
                        <a href="Cad_comissao.asp?codigo=<%=itens("codigo")%>&codigo2=<%=codigo%>&pagina=Detalhe_cliente"><img src="../img/comissao.gif" alt="Comiss�o" border=0></a>
                      <%else%>
                        <a href="Alt_comissao.asp?codigo=<%=itens("codigo")%>&codigo2=<%=codigo%>&pagina=Detalhe_cliente"><img src="../img/comissao.gif" alt="Comiss�o" border=0></a>
                      <%end if%>
                    </td>
                  </tr>
                  <%cont=cont+1%>
                  <%itens.movenext%>
               <%loop%>
            <%end if%>
          </table>
          <table width=100%>
            <tr> 
              <td align=center bgcolor=#B0B0B0>
                <a href="javascript:confirma('')"><font color=#FFFFFF><B>Excluir Selecionados</b></a>
              </td>
              <td bgcolor=#B0B0B0 align=right>
                <select name="ordem" class="texto">
                  <%if ordem="contrato.numero" then%>
                     <option value="contrato.numero" selected>N�mero
                  <%else%>
                     <option value="contrato.numero">N�mero
                  <%end if%>
                  <%if ordem="imoveis.descricao" then%>
                     <option value="imoveis.descricao" selected>Im�vel
                  <%else%>
                     <option value="imoveis.descricao">Im�vel
                  <%end if%>
                  <%if ordem="servico.descricao" then%>
                     <option value="servico.descricao" selected>Servi�o
                  <%else%>
                     <option value="servico.descricao">Servi�o
                  <%end if%>
                </select>
                <%if ordem2<>"" then%>
                   <input type="checkbox" name="ordem2" value="desc" checked>Decrescente
                <%else%>
                   <input type="checkbox" name="ordem2" value="desc">Decrescente
                <%end if%>
                <input type=image src="../img/pop_ok.gif" value="submit">
              </td>
            </tr>  
          </table> 
          <br>
          <table align=center>
            <tr>
              <td valign=top>
                <%if cINT(currentPage)>1 then%>
                   <a href="<%=request.servervariables("SCRIPT_NaME")%>?currentPage=<%=currentPage-1%>&ordem=<%=ordem%>&ordem2=<%=ordem2%>&pesquisa=<%=pesquisa%>&opcao=<%=opcao%>&codigo=<%=codigo%>"><img src="../img/anterior.gif" border=0></a>
                <%else%>
                   <img src="../img/anterior.gif">
                <%end if%>
              </td>
              <td valign=top> 
                <%if itens.PageCount>10 then
                   if itens.PageCount-currentPage<10 then
                      if cint(currentpage)<=cint(itens.PageCount-5) then
                         i=currentpage
                         x=currentPage+9
                      else
                         i=itens.PageCount-4
                         x=itens.PageCount+5
                      end if
                   else
                      if currentpage>5 then
                         i=currentPage+1
                         x=currentPage+10
                      else
                         i=6
                         x=15
                      end if
                   end if
                else
                   i=6
                   x=itens.PageCount+5
                end if
                For i = i-5 to x-5
                   if i<10 then
                     h=0
                   else
                     h=""
                   end if
                   If i = cINT( currentPage ) THEN%>
                      [ <b><%=h&i%></b> ]
                   <%ELSE%>
                      [ <a href="<%=request.servervariables("SCRIPT_NaME")%>?currentPage=<%=h&i%>&ordem=<%=ordem%>&ordem2=<%=ordem2%>&contrario=<%=contrario%>&pesquisa=<%=pesquisa%>&opcao=<%=opcao%>&codigo=<%=codigo%>"><%=h&i%></a> ]
                   <%END IF
                Next%>
              </td>
              <td valign=top>
                <%if cINT(currentPage)<itens.PageCount then%>
                   <a href="<%=request.servervariables("SCRIPT_NaME")%>?currentPage=<%=currentPage+1%>&ordem=<%=ordem%>&ordem2=<%=ordem2%>&contrario=<%=contrario%>&pesquisa=<%=pesquisa%>&opcao=<%=opcao%>&codigo=<%=codigo%>"><img src="../img/proxima.gif" border=0></a>
                <%else%>
                   <img src="../img/proxima.gif">
                <%end if%>
              </td>
            </tr>
          </table>  
        </td>
      </tr>
      </form>
    </table>
    <table width=100% background="../img/rod_2.gif"><tr><td><br><br></td></tr></table>      
    </td>
  </tr>
</table>
</body>
</html>

