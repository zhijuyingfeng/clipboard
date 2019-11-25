<%@ page import="java.io.File" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.Objects" %>

<html>
    <head>
        <title>My clipboard</title>
        <meta charset="UTF-8">
        <link rel="shortcut icon" type="image/x-icon" href="clipboard.ico"/>
        <link rel="stylesheet" href="index.css">
        <script type="text/javascript" src="index.js"></script>
    </head>
    <body>
        <div id="sentences">
            <%
                String sentence_path=application.getInitParameter("project_path")
                        +application.getInitParameter("sentence_file_path");
                File folder=new File(sentence_path);
                for(final String file: Objects.requireNonNull(folder.list()))
                {
                    try
                    {
                        String str=Files.readString(Paths.get(sentence_path+file));
                        out.println(str);
                        if(str.length()>0)
                            out.println("<hr>");
                    }
                    catch (IOException e)
                    {
                        e.printStackTrace();
                    }
                }
            %>
        </div>

        <div id="commit_sentence_div">
            <textarea id="textarea" placeholder="Input here"></textarea>
            <input type="button" value="submit" id="commit_sentence" onclick="commit_sentence()">
        </div>

        <div id="upload_file">
            <hr>
            <input type="file" id="file">
            <input type="button" value="upload" id="upload" onclick="upload_file()">
            <hr>
        </div>

        <div id="files">
            <%
                String data_path=application.getInitParameter("project_path")
                    +application.getInitParameter("data_path");
                folder=new File(data_path);
                for(final File file: Objects.requireNonNull(folder.listFiles()))
                {
                    if(file.isFile())
                    {
                        String entry="<a href=";
                        entry+=application.getInitParameter("data_path")+file.getName();
                        entry+=">"+file.getName();
                        entry+="</a><br>";
                        out.println(entry);
                    }
                }
            %>
        </div>
    </body>
</html>