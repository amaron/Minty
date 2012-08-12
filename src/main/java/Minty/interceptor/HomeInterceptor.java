package Minty.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class HomeInterceptor extends HandlerInterceptorAdapter {

    private final ThreadLocal<Long> userID;



    @Autowired
    public HomeInterceptor(@Qualifier("userID") ThreadLocal<Long> userID) {
        this.userID = userID;
    }

    @Override public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {

        HttpSession session = request.getSession(false);
        if (session != null) {
            String userName = (String) session.getAttribute("userName");
            if (userName != null) {
                userID.set((Long) session.getAttribute("userID"));
                System.out.println("checking if homeinterceptor works, user id is "+ userID + request.getRequestURL()+" with value:"+userID.get());
                response.sendRedirect("/home");
                return false;
            }
        }

        return true;
    }
}