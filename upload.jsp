<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List" %>
<%
    String path=application.getInitParameter("project_path")
            +application.getInitParameter("data_path");
    File file;
    int maxFileSize = (2000 <<20);
    int maxMemSize = (2000 <<20);
    DiskFileItemFactory factory=new DiskFileItemFactory();
    //maximum size that will be stored in memory
    factory.setSizeThreshold(maxMemSize);

    //Location to save data that is lager than maxMemSize
    factory.setRepository(new File(application.getInitParameter("project_path")+"temp/"));

    //Create a new file upload handler
    ServletFileUpload upload=new ServletFileUpload(factory);

    //maximum size to be uploaded
    upload.setSizeMax(maxFileSize);

    try
    {
        //Parse the request to get file items
        List fileItems=upload.parseRequest(request);
//        out.println(fileItems.size());
        //Process the uploaded file items
        Iterator i=fileItems.iterator();

        while(i.hasNext())
        {
            FileItem fi=(FileItem)i.next();
            //The return value of fi.isFormField is false if it represents an uploaded file
            if(!fi.isFormField())
            {
                //Get the uploaded file parameters
                String fieldName=fi.getFieldName();
                String fileName=fi.getName();
                boolean isInMemory=fi.isInMemory();
                long sizeInBytes=fi.getSize();

                //Write the file
                if(fileName.lastIndexOf("/")>=0)
                {
                    file=new File(path+fileName.substring(fileName.lastIndexOf("/")));
                }
                else
                {
                    file=new File(path+fileName.substring(fileName.lastIndexOf("/")+1));
                }
                fi.write(file);
//                out.println("OK");
            }
        }
    }
    catch (Exception ex)
    {
        out.println("Error:"+ex);
    }
%>