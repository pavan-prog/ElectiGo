package voting.application.home.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import voting.application.admin.services.AdminServices;
import voting.application.news.entities.News;
import voting.application.news.services.NewsService;

@Controller
public class HomeController{
	@Autowired
	AdminServices adminServices;
	
	@Autowired
	NewsService newsService ;
	
	@GetMapping("/")
	public String openHomePage(Model model) {
		
		List<News> news = newsService.fetchAllNews();
		
		System.out.println("news:::::::::"+news);
		
		model.addAttribute("news", news);
		
		System.out.println("\n Inside openHomePage()");

		return "homePage";
	}
}