package voting.application.news.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import voting.application.news.entities.News;
import voting.application.news.services.NewsService;

@Controller
@RequestMapping("/news")
public class NewsController {

    @Autowired
    NewsService newsService;

    @GetMapping("/openRegistrationPage")
    public String openRegistrationPage() {
        return "news/registration"; 
    }

    @PostMapping("/registration")
    public ModelAndView registerNews(@ModelAttribute News news, ModelAndView mView) {
        try {
            newsService.addNews(news);
            mView.addObject("message", "News registered successfully!");
        } catch (IOException | SQLException e) {
            e.printStackTrace();
            mView.addObject("message", "Failed to register news. Please try again.");
        }
        mView.setViewName("news/registration");
        return mView;
    }

    @GetMapping("/all")
    public String viewAllNews(Model model) {
        try {
            List<News> newsList = newsService.fetchAllNews();
            System.out.println("Fetched News"+newsList.size());
            model.addAttribute("newsList", newsList);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Error fetching news list.");
        }
        return "news/view"; 
    }
    
    @GetMapping("/allVoter")
    public String viewAllVoterNews(Model model) {
        try {
            List<News> newsList = newsService.fetchAllNews();
            System.out.println("Fetched News"+newsList.size());
            model.addAttribute("newsList", newsList);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Error fetching news list.");
        }
        return "news/viewVoter"; 
    }

    @GetMapping("/updateNewsPage")
    public String updateNewsPage(@RequestParam(value = "id", required = true) Integer id, Model model) {
        try {
            News news = newsService.getNewsById(id);
            if (news == null) {
                model.addAttribute("error", "News with the specified ID does not exist.");
                return "redirect:/news/all";
            }
            model.addAttribute("news", news);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Error fetching news details.");
        }
        return "news/update"; 
    }

    @PostMapping("/updateNews")
    public ModelAndView updateNews(@ModelAttribute News news, ModelAndView mView) {
        try {
            boolean isUpdated = newsService.updateNews(news);
            mView.addObject("message", isUpdated ? "News updated successfully!" : "Failed to update news.");
        } catch (Exception e) {
            e.printStackTrace();
            mView.addObject("message", "Error while updating news.");
        }
        mView.setViewName("news/update");
        return mView;
    }

    @GetMapping("/delete")
    public String deleteNews(@RequestParam(value = "id", required = true) Integer id, Model model) {
        try {
            int result = newsService.deleteNews(id);
            model.addAttribute("message", result > 0 ? "News deleted successfully." : "Failed to delete news.");
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Error deleting news.");
        }
        return "redirect:/news/all";
    }
}
