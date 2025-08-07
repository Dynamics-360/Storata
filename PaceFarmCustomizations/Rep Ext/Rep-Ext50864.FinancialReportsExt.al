reportextension 50864 FinancialReports extends "Account Schedule"
{
    dataset
    {
        // Add changes to dataitems and columns here
        add(AccScheduleName)
        {
            column(CompanyInfoPicture; company.Picture)
            {

            }
        }
    }

    requestpage
    {
        // Add changes to the requestpage here
    }

    rendering
    {
        layout("D360 -FinancialReports")
        {
            Type = RDLC;
            LayoutFile = './Rep Ext/Layouts/50864_PFFinancialReports.rdl';
        }
    }

    var
        Company: Record "Company Information";

    trigger OnPreReport()
    var
        CompanyInfo: Record "Company Information";
    begin
        if CompanyInfo.get() then begin
            CompanyInfo.CalcFields(CompanyInfo.Picture);
            Company.Picture := CompanyInfo.Picture;
        end;
    end;
}