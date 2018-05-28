package Servlet;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet Filter implementation class session_filter
 */
@WebFilter(value="/Java_dyn_project/WebContent/jsp_files")
public class session_filter implements Filter {

    /**
     * Default constructor. 
     */
    public session_filter() {
        // TODO Auto-generated constructor stub
    	super();
    }

	/**
	 * @return 
	 * @see Filter#destroy()
	 */
    public void destroy()
    {}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpServletResponse res = (HttpServletResponse) response;
		
		res.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
		res.setHeader("Pragma","no-cache");
		res.setDateHeader("Expires", 0);
		// pass the request along the filter chain
		chain.doFilter(request, res);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
