package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

import org.hibernate.Session;
import org.hibernate.Transaction;

import helper.FactoryProvider;
import models.Ticket;

@WebServlet("/ResolveTicket")
public class ResolveTicket extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ResolveTicket() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");

        Session session = FactoryProvider.getFactory().openSession();
        Transaction tx = session.beginTransaction();
        String message = "";
        Ticket tkt = session.get(Ticket.class, id);
        if (tkt == null) {
            message = "Ticket not found";
        } else {
            tkt.setStatus(status);
            session.merge(tkt);
            tx.commit();
            message = "Ticket Resolved successfully";
        }
        request.setAttribute("message", message);
        RequestDispatcher rd = request.getRequestDispatcher("close.jsp");
        rd.forward(request, response);
        session.close();
    }
}
