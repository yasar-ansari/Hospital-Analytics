# 1 Total Bookings
SELECT COUNT(*) AS total_bookings
FROM fact_bookings;
# This gives us the total booking volume across the dataset.

# 2 Total Revenue (Realized)
SELECT SUM(revenue_realized) AS total_revenue
FROM fact_bookings
WHERE revenue_realized > 0;
# We filtered on positive realized revenue to exclude cancellations and no-shows.

# 3 CANCELLED BOOKINGS
SELECT COUNT(*) AS cancelled_bookings
FROM fact_bookings
WHERE booking_status = 'Cancelled';
# Bookings that were cancelled.

# 4 Bookings that were cancelled.
SELECT SUM(revenue_generated) AS revenue_loss
FROM fact_bookings
WHERE booking_status = 'Cancelled';
# Revenue that could have been earned but was lost

# 5 CANCELLATION RATE
SELECT 
    COUNT(CASE WHEN booking_status = 'Cancelled' THEN 1 END) * 1.0
    / COUNT(*) AS cancellation_rate
FROM fact_bookings;
# % of bookings cancelled.

# 6 AVERAGE RATING
SELECT AVG(ratings_given) AS avg_rating
FROM fact_bookings
WHERE ratings_given IS NOT NULL;
# Customer satisfaction for completed stays. Ratings only exist for completed stays.

# 7 OCCUPANCY %
SELECT 
    SUM(successful_bookings) * 1.0 / SUM(capacity) AS occupancy_pct
FROM fact_aggregated_bookings;
# How much capacity was actually utilized

# 8 CITY WISE REVENUE
SELECT 
    h.city,
    SUM(f.revenue_realized) AS revenue
FROM fact_bookings f
JOIN dim_hotels h
  ON f.property_id = h.property_id
GROUP BY h.city
ORDER BY revenue DESC;
# Revenue Contribution By City.

# 9 CLASS WISE REVENUE
SELECT
    r.room_class,
    SUM(f.revenue_realized) AS revenue
FROM fact_bookings f
JOIN dim_rooms r
  ON f.room_category = r.room_id
GROUP BY r.room_class
ORDER BY revenue DESC;
# Revenue By Room Class

# 10 WEEKLDAY VS WEEKEND BOOKINGS
SELECT
    d.day_type,
    COUNT(*) AS bookings
FROM fact_bookings f
JOIN dim_date d
  ON f.check_in_date = d.date
GROUP BY d.day_type;
# Demand Pattern

# 11 Weekly / Monthly Trends
SELECT
    d.month_year,
    COUNT(*) AS total_bookings
FROM fact_bookings f
JOIN dim_date d
  ON f.check_in_date = d.date
GROUP BY d.month_year
ORDER BY d.month_year;
# Time-based booking behavior







