package com.order.web.servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.order.model.Food;
import com.order.service.FoodService;
import com.order.service.FoodTypeService;

import cn.hutool.core.convert.Convert;
import cn.hutool.core.util.IdUtil;

@WebServlet("/addFood")
public class AddFoodServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private FoodService foodService = new FoodService();
	private FoodTypeService ftService = new FoodTypeService();
	private long maxFileSize = 512000;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Food food = new Food();
		ArrayList<String> paramList = new ArrayList<String>();
		String imgPath = "";
		try {
			/**
			 * 创建ServletFileUpload实例
			 */
			DiskFileItemFactory factory = new DiskFileItemFactory();
			String realPath = this.getServletContext().getRealPath("/");
			// 设置缓存目录
			factory.setRepository(new File(realPath));
			ServletFileUpload upload = new ServletFileUpload(factory);
			// 表单大小总和
//			upload.setSizeMax(maxFileSize);
			// 单个文件不得超过
			upload.setFileSizeMax(maxFileSize);
			// 处理中文乱码
			upload.setHeaderEncoding("UTF-8");

			if (ServletFileUpload.isMultipartContent(request)) { // 判断是否为带文件表单
				List<FileItem> list = upload.parseRequest(request);
				for (FileItem item : list) {
					if (item.isFormField()) {
						String value = item.getString("UTF-8"); // 表单字段的输入值
						paramList.add(value);
					} else {
						String fileName = item.getName();// 表单的输入框值
						String name = item.getFieldName();// 表单的变量名
						InputStream input = item.getInputStream();
						/**
						 * 0下标为服务端文件存放真实目录，1下标则是存进数据库前端访问的路径
						 */
						// 存储目录
						String dir = this.getServletContext().getRealPath("/upload");
						if (fileName.contains("/")) {
							fileName = fileName.substring(name.lastIndexOf("/") + 1);
							System.out.println("fileName=" + fileName);
						}
						String path = IdUtil.fastSimpleUUID() + fileName;
						imgPath += path;
						System.out.println("imgPath====" + imgPath);
						// 数据库存取的访问路径

						// 存储目录健壮性判断
						File driSave = new File(dir);
						if (!driSave.exists()) {
							driSave.mkdir();
						}
						File saveFile = new File(dir, path);
						// 存放目录健壮性判断
						if (!saveFile.exists()) {
							saveFile.createNewFile();
						}
						saveFile.getAbsolutePath();
						item.write(saveFile);
						item.delete();
						input.close();
					}
				}
			} else {
				System.out.println("表单不存在文件");
			}
			food.setName(paramList.get(0));
			food.setPrice(Convert.toDouble(paramList.get(1)));
			food.setFtid(Convert.toInt(paramList.get(2)));
			food.setInfo(paramList.get(3));
			food.setImage(imgPath);
			foodService.add(food);
			
			request.setAttribute("foodList", foodService.findAll());
			request.setAttribute("ftList", ftService.findAll());
			request.getRequestDispatcher("admin/m_food.jsp").forward(request, response);
		} catch (Exception e) {
			System.out.println(e);
		}
	}
}
