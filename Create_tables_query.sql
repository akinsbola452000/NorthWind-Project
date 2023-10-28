
-- Testing Github changes
-- Name: categories; Type: TABLE; Schema: dbo;
CREATE TABLE categories (
    category_id smallint NOT NULL PRIMARY KEY,
    category_name varchar(15) NOT NULL,
    description text,
    picture varbinary(max)
);

-- Name: customer_demographics; Type: TABLE; Schema: dbo;
CREATE TABLE dbo.customer_demographics (
    customer_type_id char(1) NOT NULL PRIMARY KEY,
    customer_desc text
);

-- Name: customers; Type: TABLE; Schema: dbo;
CREATE TABLE customers (
    customer_id char(5) NOT NULL PRIMARY KEY,
    company_name varchar(40) NOT NULL,
    contact_name varchar(30),
    contact_title varchar(30),
    address varchar(60),
    city varchar(15),
    region varchar(15),
    postal_code varchar(10),
    country varchar(15),
    phone varchar(24),
    fax varchar(24)
);

-- Name: customer_customer_demo; Type: TABLE; Schema: dbo;
CREATE TABLE customer_customer_demo (
    customer_id char(5) NOT NULL,
    customer_type_id char(1) NOT NULL,
    PRIMARY KEY (customer_id, customer_type_id),
    FOREIGN KEY (customer_type_id) REFERENCES dbo.customer_demographics,
    FOREIGN KEY (customer_id) REFERENCES dbo.customers
);

-- Name: employees; Type: TABLE; Schema: dbo;
CREATE TABLE employees (
    employee_id smallint NOT NULL PRIMARY KEY,
    last_name varchar(20) NOT NULL,
    first_name varchar(10) NOT NULL,
    title varchar(30),
    title_of_courtesy varchar(25),
    birth_date date,
    hire_date date,
    address varchar(60),
    city varchar(15),
    region varchar(15),
    postal_code varchar(10),
    country varchar(15),
    home_phone varchar(24),
    extension varchar(4),
    photo varbinary(max),
    notes text,
    reports_to smallint,
    photo_path varchar(255),
    FOREIGN KEY (reports_to) REFERENCES dbo.employees
);

-- Name: suppliers; Type: TABLE; Schema: dbo;
CREATE TABLE suppliers (
    supplier_id smallint NOT NULL PRIMARY KEY,
    company_name varchar(40) NOT NULL,
    contact_name varchar(30),
    contact_title varchar(30),
    address varchar(60),
    city varchar(15),
    region varchar(15),
    postal_code varchar(10),
    country varchar(15),
    phone varchar(24),
    fax varchar(24),
    homepage text
);

-- Name: products; Type: TABLE; Schema: dbo;
CREATE TABLE products (
    product_id smallint NOT NULL PRIMARY KEY,
    product_name varchar(40) NOT NULL,
    supplier_id smallint,
    category_id smallint,
    quantity_per_unit varchar(20),
    unit_price real,
    units_in_stock smallint,
    units_on_order smallint,
    reorder_level smallint,
    discontinued bit NOT NULL,
    FOREIGN KEY (category_id) REFERENCES dbo.categories,
    FOREIGN KEY (supplier_id) REFERENCES dbo.suppliers
);

-- Name: region; Type: TABLE; Schema: dbo;
CREATE TABLE region (
    region_id smallint NOT NULL PRIMARY KEY,
    region_description char(1) NOT NULL
);

-- Name: shippers; Type: TABLE; Schema: dbo;
CREATE TABLE shippers (
    shipper_id smallint NOT NULL PRIMARY KEY,
    company_name varchar(40) NOT NULL,
    phone varchar(24)
);

-- Name: orders; Type: TABLE; Schema: dbo;
CREATE TABLE orders (
    order_id smallint NOT NULL PRIMARY KEY,
    customer_id char(5),
    employee_id smallint,
    order_date date,
    required_date date,
    shipped_date date,
    ship_via smallint,
    freight real,
    ship_name varchar(40),
    ship_address varchar(60),
    ship_city varchar(15),
    ship_region varchar(15),
    ship_postal_code varchar(10),
    ship_country varchar(15),
    FOREIGN KEY (customer_id) REFERENCES dbo.customers,
    FOREIGN KEY (employee_id) REFERENCES dbo.employees,
    FOREIGN KEY (ship_via) REFERENCES dbo.shippers
);

-- Name: territories; Type: TABLE; Schema: dbo;
CREATE TABLE territories (
    territory_id varchar(20) NOT NULL PRIMARY KEY,
    territory_description char(1) NOT NULL,
    region_id smallint NOT NULL,
    FOREIGN KEY (region_id) REFERENCES dbo.region
);

-- Name: employee_territories; Type: TABLE; Schema: dbo;
CREATE TABLE employee_territories (
    employee_id smallint NOT NULL,
    territory_id varchar(20) NOT NULL,
    PRIMARY KEY (employee_id, territory_id),
    FOREIGN KEY (territory_id) REFERENCES dbo.territories,
    FOREIGN KEY (employee_id) REFERENCES dbo.employees
);

-- Name: order_details; Type: TABLE; Schema: dbo;
CREATE TABLE order_details (
    order_id smallint NOT NULL,
    product_id smallint NOT NULL,
    unit_price real NOT NULL,
    quantity smallint NOT NULL,
    discount real NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (product_id) REFERENCES dbo.products,
    FOREIGN KEY (order_id) REFERENCES dbo.orders
);

-- Name: us_states; Type: TABLE; Schema: dbo;
CREATE TABLE us_states (
    state_id smallint NOT NULL PRIMARY KEY,
    state_name varchar(100),
    state_abbr varchar(2),
    state_region varchar(50)
);
