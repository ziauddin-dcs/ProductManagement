using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ProductManagement.Models
{
    public class DatabaseHelper
    {
        private string _connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        public SqlConnection GetConnection()
        {
            return new SqlConnection(_connectionString);
        }

        public void InsertProduct(Product product)
        {
            using (var conn = GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("INSERT INTO Products (ProductName, CategoryID, SubcategoryID, Qty, Price, Total) VALUES (@ProductName, @CategoryID, @SubcategoryID, @Qty, @Price, @Total)", conn);
                cmd.Parameters.AddWithValue("@ProductName", product.ProductName);
                cmd.Parameters.AddWithValue("@CategoryID", product.CategoryID);
                cmd.Parameters.AddWithValue("@SubcategoryID", product.SubcategoryID);
                cmd.Parameters.AddWithValue("@Qty", product.Qty);
                cmd.Parameters.AddWithValue("@Price", product.Price);
                cmd.Parameters.AddWithValue("@Total", product.Total);
                cmd.ExecuteNonQuery();
            }
        }

        public void UpdateProduct(Product product)
        {
            using (var conn = GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("UPDATE Products SET ProductName = @ProductName, CategoryID = @CategoryID, SubcategoryID = @SubcategoryID, Qty = @Qty, Price = @Price, Total = @Total WHERE ProductID = @ProductID", conn);
                cmd.Parameters.AddWithValue("@ProductName", product.ProductName);
                cmd.Parameters.AddWithValue("@CategoryID", product.CategoryID);
                cmd.Parameters.AddWithValue("@SubcategoryID", product.SubcategoryID);
                cmd.Parameters.AddWithValue("@Qty", product.Qty);
                cmd.Parameters.AddWithValue("@Price", product.Price);
                cmd.Parameters.AddWithValue("@Total", product.Total);
                cmd.Parameters.AddWithValue("@ProductID", product.ProductID);
                cmd.ExecuteNonQuery();
            }
        }

        public List<Product> GetProducts()
        {
            List<Product> products = new List<Product>();

            string query = @"
        SELECT p.ProductID, p.ProductName, p.CategoryID, c.CategoryName, 
               p.SubcategoryID, s.SubcategoryName, p.Qty, p.Price, p.Total
        FROM Products p
        INNER JOIN Categories c ON p.CategoryID = c.CategoryID
        LEFT JOIN Subcategories s ON p.SubcategoryID = s.SubcategoryID";

            // Create an instance of DbHelper to get the connection

            using (var connection = GetConnection()) // Use dbHelper to get the connection
            {
                connection.Open();

                using (var command = new SqlCommand(query, connection))
                {
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var product = new Product
                            {
                                ProductID = reader.GetInt32(0),
                                ProductName = reader.GetString(1),
                                CategoryID = reader.GetInt32(2),
                                Category = new Category
                                {
                                    CategoryID = reader.GetInt32(2),
                                    CategoryName = reader.GetString(3)
                                },
                                SubcategoryID = reader.GetInt32(4),
                                Subcategory = new Subcategory
                                {
                                    SubcategoryID = reader.GetInt32(4),
                                    SubcategoryName = reader.GetString(5)
                                },
                                Qty = reader.GetInt32(6),
                                Price = reader.GetDecimal(7),
                                Total = reader.GetDecimal(8)
                            };
                            products.Add(product);
                        }
                    }
                }
            }

            return products;
        }

        public Product GetProductById(int id)
        {
            Product product = null;
            using (var conn = GetConnection())
            {
                conn.Open();

                // Modify the query to join with Categories and Subcategories tables
                var cmd = new SqlCommand(@"
            SELECT p.ProductID, p.ProductName, p.CategoryID, c.CategoryName, 
                   p.SubcategoryID, s.SubcategoryName, p.Qty, p.Price, p.Total
            FROM Products p
            INNER JOIN Categories c ON p.CategoryID = c.CategoryID
            LEFT JOIN Subcategories s ON p.SubcategoryID = s.SubcategoryID
            WHERE p.ProductID = @ProductID", conn);

                cmd.Parameters.AddWithValue("@ProductID", id);

                var reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    product = new Product
                    {
                        ProductID = (int)reader["ProductID"],
                        ProductName = reader["ProductName"].ToString(),
                        CategoryID = (int)reader["CategoryID"],
                        Category = new Category
                        {
                            CategoryID = (int)reader["CategoryID"],
                            CategoryName = reader["CategoryName"].ToString()
                        },
                        SubcategoryID = (int)reader["SubcategoryID"],
                        Subcategory = new Subcategory
                        {
                            SubcategoryID = (int)reader["SubcategoryID"],
                            SubcategoryName = reader["SubcategoryName"].ToString()
                        },
                        Qty = (int)reader["Qty"],
                        Price = (decimal)reader["Price"],
                        Total = (decimal)reader["Total"]
                    };
                }
            }
            return product;
        }
        public void DeleteProduct(int id)
        {
            using (var conn = GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("DELETE FROM Products WHERE ProductID = @ProductID", conn);
                cmd.Parameters.AddWithValue("@ProductID", id);
                cmd.ExecuteNonQuery();
            }
        }
    }
}