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

    // ����ļ��Ĵ�С���������ֵ����ֱ��д����̣�����������ڴ滺���� 
    private int threshold = 0;
    // ����������ʱ�ļ��ϴ�Ŀ¼ 
    private String repository;
    // �����ϴ��ļ���С�����ֵ 
    private long fileSizeMax;

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");


        DiskFileItemFactory factory = new DiskFileItemFactory();

        // �����ڴ滺�����Ĵ�С 
        factory.setSizeThreshold(threshold);

        // ������ʱ�ļ��ϴ�Ŀ¼ 
        factory.setRepository(new File(repository));

        // �����ļ��ϳ���ʵ�� 
        ServletFileUpload upload = new ServletFileUpload(factory);

        // ���õ����ϴ��ļ���С�����ֵ 
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
        out.println("�ϴ��ɹ�");
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * ���ļ�д�����,ע��Ϊ�����Ч��, ����û��ֱ�ӵ���FileItem.get()����ȡ�ļ�����,
     * ��Ϊ����ļ��ǳ���Ļ�,���罫���ܲ���,����ʹ���˻���������ȡ, ����ϴ����ļ���С,������ʹ���������
     * 
     * @param fileItem
     */ 
    @SuppressWarnings("deprecation")
    private void writeFiles(FileItem fileItem, HttpServletRequest request,int value)
            throws IOException {
        // ����ͬ��������ϴ��ļ�ʱ,�ļ�����·��������,�е������ֻ����ʾ�ļ���
        // �����е������ȴ�Ὣ����·��Ҳ����,�����Ҫ���� 
        String fileNameString = fileItem.getName();
        int start = fileNameString.indexOf("//");
        String fileName = fileNameString.substring(start + 1);

        // ��õ�ǰwebӦ�õĸ�·�� 
        String parent = request.getRealPath(repository);
        productManager.getInstance().receiveimage(value, fileName);
        // ����һ��File����,�����ǵ�ǰwebӦ�õĸ�·�������ļ��� 
        File file = new File(parent, fileName);

        // �������һ�������� 
        byte[] buffer = new byte[1024];

        // ���ʵ���ܹ���Ч��ȡ���ֽ�����ĳ��� 
        int length = 0;
        // ���FileItem���ļ������� 
        InputStream is = fileItem.getInputStream();
        // ����һ���ļ������ 
        FileOutputStream fos = new FileOutputStream(file);

        // ���ֽ�����˳����뻺����,����Ѿ��������ֽ���������ĩβ,
        // Ҳ����lengthС�ڻ����0ʱ,��ȡ���� 
        while ((length = is.read(buffer)) > 0) {
            fos.write(buffer, 0, length);
        }

        // �ǵùر����������� 
        fos.close();
        is.close();
    }

    /**
     * ����servlet�ĳ�ʼ������
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