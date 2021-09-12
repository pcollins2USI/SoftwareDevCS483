using FirstProject.Helper;
using FirstProject.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FirstProject
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string UserRegister(RegisterModel Data)
        {

            try
            {
                Db db = new Db();
                SqlParameter[] sParams = new SqlParameter[6];
                sParams[0] = new SqlParameter("@FullName", Data.FullName);
                sParams[1] = new SqlParameter("@Email", Data.Email);
                sParams[2] = new SqlParameter("@Password", StringHelper.Encrypt(Data.Password));
                sParams[3] = new SqlParameter("@AvaiblityFrom", Data.AvaiblityFrom);
                sParams[4] = new SqlParameter("@AvaiblityTo", Data.AvaiblityTo);
                sParams[5] = new SqlParameter("@Interval", Data.Interval);


                int FacultyId = db.executeScheduleProcedureWithId("InsertUpdateFacultyDetails", sParams);

                FormsAuthenticationTicket authTicket = new FormsAuthenticationTicket
                    (
                        1,
                       FacultyId.ToString(),
                        DateTime.Now,
                        DateTime.Now.AddMinutes(50000),
                        true,
                        FacultyId.ToString()
                    );
                    string encryptedTicket = FormsAuthentication.Encrypt(authTicket);
                    HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);
                    authCookie.Expires = DateTime.Now.AddMinutes(50000);
                HttpContext.Current.Response.Cookies.Add(authCookie);
                return "Success";
            }
            catch(Exception ex)
            {

            }

            return "Error";
        }

      
    }
}