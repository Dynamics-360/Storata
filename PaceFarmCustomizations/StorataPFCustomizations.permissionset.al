permissionset 50850 PFCustomizations
{
    Assignable = true;
    Permissions = tabledata "50850_TabImportSalesHeader" = RIMD,
        tabledata "50851_TabImportSalesLines" = RIMD,
        table "50850_TabImportSalesHeader" = X,
        table "50851_TabImportSalesLines" = X,
        codeunit EventSubs = X,
        codeunit Processing = X,
        page "50851_PagImportSalesLines" = X,
        page D360_SalesHeaer = X;
}