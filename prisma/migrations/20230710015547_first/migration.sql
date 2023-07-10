-- CreateTable
CREATE TABLE "User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "email" TEXT NOT NULL,
    "username" TEXT,
    "password" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Post" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT,
    "content" TEXT,
    "published" BOOLEAN NOT NULL DEFAULT false,
    "authorId" INTEGER,
    CONSTRAINT "Post_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Product" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT,
    "quantity" INTEGER NOT NULL DEFAULT 0,
    "price" INTEGER NOT NULL DEFAULT 999,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "categoryId" INTEGER NOT NULL,
    CONSTRAINT "Product_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Category" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Company" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "business_name" TEXT NOT NULL,
    "identification_code" TEXT NOT NULL,
    "address" TEXT,
    "phone1" TEXT,
    "phone2" TEXT,
    "email" TEXT,
    "legal_representative" TEXT,
    "image" TEXT,
    "currency" TEXT,
    "retainer" BOOLEAN NOT NULL DEFAULT false,
    "date_resolution" DATETIME,
    "resolution_retainer" TEXT,
    "renta_retainer" TEXT,
    "ecommerce" BOOLEAN NOT NULL DEFAULT false,
    "pucedit" BOOLEAN NOT NULL DEFAULT false,
    "msg_puc" TEXT NOT NULL DEFAULT 'This option has a standard configuration with the list to be used any change will directly affect its accounting and will be under its responsibility',
    "contact_name" TEXT,
    "contact_phone" TEXT,
    "puc_id" INTEGER,
    "created_id" INTEGER,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "subcompanyId" INTEGER,
    CONSTRAINT "Company_subcompanyId_fkey" FOREIGN KEY ("subcompanyId") REFERENCES "Company" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Person" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "identification" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "lastname" TEXT,
    "image" TEXT,
    "address" TEXT,
    "celular" TEXT,
    "phone" TEXT,
    "status" BOOLEAN NOT NULL DEFAULT false,
    "website" TEXT,
    "birthday" DATETIME,
    "email" TEXT,
    "years_old" INTEGER,
    "created_id" INTEGER,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" INTEGER,
    CONSTRAINT "Person_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Provider" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "website" TEXT,
    "creditdays" INTEGER,
    "creditlimit" INTEGER,
    "observation" TEXT,
    "status" BOOLEAN NOT NULL DEFAULT false,
    "created_id" INTEGER,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "personId" INTEGER,
    "companyId" INTEGER,
    CONSTRAINT "Provider_personId_fkey" FOREIGN KEY ("personId") REFERENCES "Person" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Provider_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Client" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "website" TEXT,
    "creditdays" INTEGER,
    "creditlimit" INTEGER,
    "discount" INTEGER,
    "observation" TEXT,
    "status" BOOLEAN NOT NULL DEFAULT false,
    "msg_status" TEXT NOT NULL DEFAULT 'Welcome client',
    "created_id" INTEGER,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "personId" INTEGER,
    "companyId" INTEGER,
    CONSTRAINT "Client_personId_fkey" FOREIGN KEY ("personId") REFERENCES "Person" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Client_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Employee" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "salary" REAL,
    "observation" TEXT,
    "status" BOOLEAN NOT NULL DEFAULT false,
    "msg_status" TEXT NOT NULL DEFAULT 'change the status',
    "start" DATETIME,
    "end" DATETIME,
    "created_id" INTEGER,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "personId" INTEGER,
    "companyId" INTEGER,
    "supervisorId" INTEGER,
    CONSTRAINT "Employee_personId_fkey" FOREIGN KEY ("personId") REFERENCES "Person" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Employee_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Employee_supervisorId_fkey" FOREIGN KEY ("supervisorId") REFERENCES "Employee" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Partner" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "number_actions" INTEGER,
    "status" BOOLEAN NOT NULL DEFAULT false,
    "participation_percentage" REAL,
    "created_id" INTEGER,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "personId" INTEGER,
    "companyId" INTEGER,
    CONSTRAINT "Partner_personId_fkey" FOREIGN KEY ("personId") REFERENCES "Person" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Partner_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Otherperson" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "number_actions" INTEGER,
    "creditdays" INTEGER,
    "creditlimit" INTEGER,
    "observation" TEXT,
    "description" TEXT,
    "status" BOOLEAN NOT NULL DEFAULT false,
    "contractor" BOOLEAN NOT NULL DEFAULT false,
    "mayor" BOOLEAN NOT NULL DEFAULT false,
    "government" BOOLEAN NOT NULL DEFAULT false,
    "created_id" INTEGER,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "personId" INTEGER,
    "companyId" INTEGER,
    CONSTRAINT "Otherperson_personId_fkey" FOREIGN KEY ("personId") REFERENCES "Person" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Otherperson_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Payrollentity" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "code" TEXT,
    "observation" TEXT,
    "status" BOOLEAN NOT NULL DEFAULT false,
    "eps" BOOLEAN NOT NULL DEFAULT false,
    "afp" BOOLEAN NOT NULL DEFAULT false,
    "arl" BOOLEAN NOT NULL DEFAULT false,
    "sena" BOOLEAN NOT NULL DEFAULT false,
    "icbf" BOOLEAN NOT NULL DEFAULT false,
    "ccf" BOOLEAN NOT NULL DEFAULT false,
    "fondocesantias" BOOLEAN NOT NULL DEFAULT false,
    "created_id" INTEGER,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "personId" INTEGER,
    "companyId" INTEGER,
    CONSTRAINT "Payrollentity_personId_fkey" FOREIGN KEY ("personId") REFERENCES "Person" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Payrollentity_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "MastercardVisas" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "code" TEXT,
    "description" TEXT,
    "status" BOOLEAN NOT NULL DEFAULT false,
    "created_id" INTEGER,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "personId" INTEGER,
    "companyId" INTEGER,
    CONSTRAINT "MastercardVisas_personId_fkey" FOREIGN KEY ("personId") REFERENCES "Person" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "MastercardVisas_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Category_name_key" ON "Category"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Company_identification_code_key" ON "Company"("identification_code");

-- CreateIndex
CREATE UNIQUE INDEX "Company_subcompanyId_key" ON "Company"("subcompanyId");

-- CreateIndex
CREATE UNIQUE INDEX "Person_identification_key" ON "Person"("identification");

-- CreateIndex
CREATE UNIQUE INDEX "Person_userId_key" ON "Person"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Provider_personId_key" ON "Provider"("personId");

-- CreateIndex
CREATE UNIQUE INDEX "Provider_companyId_key" ON "Provider"("companyId");

-- CreateIndex
CREATE UNIQUE INDEX "Client_personId_key" ON "Client"("personId");

-- CreateIndex
CREATE UNIQUE INDEX "Client_companyId_key" ON "Client"("companyId");

-- CreateIndex
CREATE UNIQUE INDEX "Employee_personId_key" ON "Employee"("personId");

-- CreateIndex
CREATE UNIQUE INDEX "Employee_companyId_key" ON "Employee"("companyId");

-- CreateIndex
CREATE UNIQUE INDEX "Employee_supervisorId_key" ON "Employee"("supervisorId");

-- CreateIndex
CREATE UNIQUE INDEX "Partner_personId_key" ON "Partner"("personId");

-- CreateIndex
CREATE UNIQUE INDEX "Partner_companyId_key" ON "Partner"("companyId");

-- CreateIndex
CREATE UNIQUE INDEX "Otherperson_personId_key" ON "Otherperson"("personId");

-- CreateIndex
CREATE UNIQUE INDEX "Otherperson_companyId_key" ON "Otherperson"("companyId");

-- CreateIndex
CREATE UNIQUE INDEX "Payrollentity_personId_key" ON "Payrollentity"("personId");

-- CreateIndex
CREATE UNIQUE INDEX "Payrollentity_companyId_key" ON "Payrollentity"("companyId");

-- CreateIndex
CREATE UNIQUE INDEX "MastercardVisas_personId_key" ON "MastercardVisas"("personId");

-- CreateIndex
CREATE UNIQUE INDEX "MastercardVisas_companyId_key" ON "MastercardVisas"("companyId");
