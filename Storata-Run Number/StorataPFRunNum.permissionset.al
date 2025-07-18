permissionset 60450 Storata_PFRunNumber
{
    Assignable = true;
    Permissions = tabledata "Call Sheet" = RIMD,
        tabledata "Customer Runs" = RIMD,
        tabledata "Customer SKU" = RIMD,
        tabledata DefaultSKUBuffer = RIMD,
        tabledata Holidays = RIMD,
        tabledata Runs = RIMD,
        table "Call Sheet" = X,
        table "Customer Runs" = X,
        table "Customer SKU" = X,
        table DefaultSKUBuffer = X,
        table Holidays = X,
        table Runs = X,
        report "Update Call Sheet" = X,
        codeunit "Run Number Mgt." = X,
        page "Call Sheet" = X,
        page "Customer Runs" = X,
        page "Customer SKU" = X,
        page CustomerSKUBuffer = X,
        page Holidays = X,
        page "Run Numbers" = X,
        page "Run Numbers List" = X;
}