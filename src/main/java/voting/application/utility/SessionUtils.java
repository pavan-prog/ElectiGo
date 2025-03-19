package voting.application.utility;

import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.ModelAndView;

public class SessionUtils {
    public static boolean isAuthenticated(HttpSession session) {
        return session.getAttribute("loggedInAdmin") != null;
    }

    public static ModelAndView redirectIfNotAuthenticated(HttpSession session) {
        if (!isAuthenticated(session)) {
            ModelAndView mView = new ModelAndView("redirect:/admin/openLoginPage");
            mView.addObject("message", "Please login to continue.");
            return mView;
        }
        return null;
    }
}
