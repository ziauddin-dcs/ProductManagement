using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ProductManagement.Models;

namespace ProductManagement.Controllers
{
    public class ProductController : Controller
    {
        private DatabaseHelper _dbHelper = new DatabaseHelper();

        // GET: Product/Index
        public ActionResult Index()
        {
            var products = _dbHelper.GetProducts();
            return View(products);
        }

        // GET: Product/Create
        public ActionResult Create()
        {
            //ViewBag.Categories = GetCategories();

            List<Category> categories = GetCategories();

            // Create a SelectList from the categories list
            ViewBag.Categories = new SelectList(categories, "CategoryID", "CategoryName");
            return View();
        }

        // GET: Get Subcategories based on Category
        public JsonResult GetSubcategories(int categoryId)
        {
            var subcategories = GetSubcategoriesByCategory(categoryId);
            return Json(subcategories, JsonRequestBehavior.AllowGet);
        }

        // POST: Product/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Product product)
        {
            //if (ModelState.IsValid)
            {
                product.Total = product.Qty * product.Price;
                _dbHelper.InsertProduct(product);
                return RedirectToAction("Index");
            }
            List<Category> categories = GetCategories();
            ViewBag.Categories = new SelectList(categories, "CategoryID", "CategoryName");
            return View(product);
        }

        

        // GET: Product/Edit/5
        public ActionResult Edit(int id)
        {

            var product = _dbHelper.GetProductById(id);

            // Get all categories and create a SelectList
            List<Category> categories = GetCategories();
            ViewBag.Categories = new SelectList(categories, "CategoryID", "CategoryName", product.CategoryID); // Pass selected category

            // Get subcategories for the selected category and create a SelectList
            List<Subcategory> subcategories = GetSubcategoriesByCategory(product.CategoryID);
            ViewBag.Subcategories = new SelectList(subcategories, "SubcategoryID", "SubcategoryName", product.SubcategoryID); // Pass selected subcategory
            return View(product);
        }

        // POST: Product/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Product product)
        {
            product.Total = product.Qty * product.Price;
            _dbHelper.UpdateProduct(product);
            return RedirectToAction("Index");

        }

        // GET: Product/Delete/5
        public ActionResult Delete(int id)
        {
            var product = _dbHelper.GetProductById(id);
            return View(product);
        }

        // POST: Product/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            _dbHelper.DeleteProduct(id);
            return RedirectToAction("Index");
        }

        // Methods to interact with the database

        private List<Category> GetCategories()
        {
            var categories = new List<Category>();
            using (var conn = _dbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("SELECT * FROM Categories", conn);
                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    categories.Add(new Category
                    {
                        CategoryID = (int)reader["CategoryID"],
                        CategoryName = reader["CategoryName"].ToString()
                    });
                }
            }
            return categories;
        }

        private List<Subcategory> GetSubcategoriesByCategory(int categoryId)
        {
            var subcategories = new List<Subcategory>();
            using (var conn = _dbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("SELECT * FROM Subcategories WHERE CategoryID = @CategoryID", conn);
                cmd.Parameters.AddWithValue("@CategoryID", categoryId);
                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    subcategories.Add(new Subcategory
                    {
                        SubcategoryID = (int)reader["SubcategoryID"],
                        SubcategoryName = reader["SubcategoryName"].ToString()
                    });
                }
            }
            return subcategories;
        }

    }

}










