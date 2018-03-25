package com.syc.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.syc.product.productManager;

public class FileUploadServlet extends HttpServlet {

    private static final long serialVersionUID = 8088769669368270752L;

    // 如果文件的大小超过这个数值，将直接写入磁盘，而不会放在内存缓冲区 
    private int threshold = 0;
    // 服务器端临时文件上传目录 
    private String repository;
    // 单个上传文件大小的最大值 
    private long fileSizeMax;

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");


        DiskFileItemFactory factory = new DiskFileItemFactory();

        // 设置内存缓冲区的大小 
        factory.setSizeThreshold(threshold);

        // 设置临时文件上传目录 
        factory.setRepository(new File(repository));

        // 创建文件上出的实例 
        ServletFileUpload upload = new ServletFileUpload(factory);

        // 设置单个上传文件大小的最大值 
        upload.setFileSizeMax(fileSizeMax);

        try {
            List<FileItem> fileItems = upload.parseRequest(request);
            int value=0;
            for (FileItem fileItem : fileItems) {
          

                if (fileItem.isFormField()) {
                	  try{
                		  value =Integer.parseInt(fileItem.getString());
                      }catch(NumberFormatException e){
                      	System.out.println("error");
                      }
         
                } else {
                    writeFiles(fileItem, request,value);
                }
            }
        }  catch (FileUploadException e) {
            e.printStackTrace();
        }
        PrintWriter out=response.getWriter();
        out.println("上传成功");
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * 将文件写入磁盘,注意为了提高效率, 我们没有直接调用FileItem.get()来读取文件内容,
     * 因为如果文件非常大的话,网络将承受不了,所以使用了缓冲区来读取, 如果上传的文件很小,则大可以使用这个方法
     * 
     * @param fileItem
     */ 
    @SuppressWarnings("deprecation")
    private void writeFiles(FileItem fileItem, HttpServletRequest request,int value)
            throws IOException {
        // 处理不同的浏览器上传文件时,文件名和路径的问题,有的浏览器只会显示文件名
        // 但是有的浏览器却会将完整路径也加上,因此需要处理 
        String fileNameString = fileItem.getName();
        int start = fileNameString.indexOf("//");
        String fileName = fileNameString.substring(start + 1);

        // 获得当前web应用的根路径 
        String parent = request.getRealPath(repository);
        productManager.getInstance().receiveimage(value, fileName);
        // 构造一个File对象,规则是当前web应用的根路径加上文件名 
        File file = new File(parent, fileName);

        // 设输出流一个缓冲区 
        byte[] buffer = new byte[1024];

        // 获得实际能够有效读取的字节数组的长度 
        int length = 0;
        // 获得FileItem的文件输入流 
        InputStream is = fileItem.getInputStream();
        // 构造一个文件输出流 
        FileOutputStream fos = new FileOutputStream(file);

        // 将字节流按顺序读入缓冲区,如果已经读到了字节输入流的末尾,
        // 也就是length小于或等于0时,读取结束 
        while ((length = is.read(buffer)) > 0) {
            fos.write(buffer, 0, length);
        }

        // 记得关闭输入和输出流 
        fos.close();
        is.close();
    }

    /**
     * 设置servlet的初始化参数
     */ 
    @Override
    public void init(ServletConfig config) throws ServletException {
        String thresholdParam = config.getInitParameter("threshold");
        String repositoryParam = config.getInitParameter("repository");
        String fileSizeMaxParam = config.getInitParameter("fileSizeMax");

        if (null != thresholdParam) {
            this.threshold = Integer.parseInt(thresholdParam);
        }
        if (null != repositoryParam) {
            this.repository = repositoryParam;
        }
        if (null != repositoryParam) {
            this.fileSizeMax = Integer.parseInt(fileSizeMaxParam);
        }
    }
}