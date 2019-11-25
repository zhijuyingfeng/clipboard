function commit_sentence()
{
    let textarea=document.getElementById("textarea");
    let sentence=textarea.value;

    let xhr=new XMLHttpRequest();
    xhr.open("POST","commit_sentence.jsp",true);
    xhr.setRequestHeader('Content-Type', 'text/plain');
    xhr.send(sentence);
    xhr.onload=function()
    {
        console.log(xhr.responseText);
    }
    // location.reload();
}

function upload_file()
{
    let file=document.getElementById("file").files[0];
    let formData=new FormData();
    formData.append("file",file);
    fetch("upload.jsp",{method:"POST",body:formData});
}