using FirstProject.App_Start;
using FirstProject.Helper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FirstProject
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            script.MyProperty = "OuterPage";
          
        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="Email"></param>
        /// <param name="Password"></param>
        /// <returns></returns>
        [WebMethod]
        public static string UserLogin(string Email, string Password)
        {

            try
            {
                Db db = new Db();
                SqlParameter[] sParams = new SqlParameter[2];
                sParams[0] = new SqlParameter("@Email", Email);
                sParams[1] = new SqlParameter("@Password", StringHelper.Encrypt(Password));

                DataRow FacultyDetails = db.executeProcedure("GetFacultyDetails", sParams, true).Tables[0].Rows[0];

                if (FacultyDetails != null)
                {

                    FormsAuthenticationTicket authTicket = new FormsAuthenticationTicket
                    (
                        1,
                        FacultyDetails["facultyId"].ToString(),
                        DateTime.Now,
                        DateTime.Now.AddMinutes(50000),
                        true,
                        FacultyDetails["facultyId"].ToString()
                    );
                    string encryptedTicket = FormsAuthentication.Encrypt(authTicket);
                    HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);
                    authCookie.Expires = DateTime.Now.AddMinutes(50000);
                    HttpContext.Current.Response.Cookies.Add(authCookie);
                    return "Success";
                }
                else
                {
                    return "Invalid Username And Password";
                }

            }
            catch
            {

            }

            return "Error";
        }
    }
}