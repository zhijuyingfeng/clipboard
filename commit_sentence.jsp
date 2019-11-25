<%@ page import="org.apache.commons.io.IOUtils" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.util.Objects" %>
<%
    String sentence_path=application.getInitParameter("project_path")
            +application.getInitParameter("sentence_file_path");
    File folder=new File(sentence_path);

    long min=Long.MAX_VALUE;
    int num=0;

    int i=0;
    for(final File file: Objects.requireNonNull(folder.listFiles()))
    {
        long temp=file.lastModified();
        out.println(temp);
        if(temp<min)
        {
            min=temp;
            num=i;
        }
        i++;
    }
//    out.println(num);
//    String content=request.getParameter("content");
    String content= IOUtils.toString(request.getReader());
//    out.println(content);
    try
    {
        if(content.length()>0)
            Files.write(Paths.get(sentence_path+ Objects.requireNonNull(folder.list())[num]),content.getBytes());
        out.println("write");
    }
    catch (IOException e)
    {
        e.printStackTrace();
    }
%>

<%--content:sentence--%>