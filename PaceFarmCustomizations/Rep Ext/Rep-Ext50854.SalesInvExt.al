reportextension 50854 SalesInvExt extends "PF Posted Sales Invoice"
{
    dataset
    {
        add("Sales Invoice Header")
        {
            column(SDN; SDN)
            {
            }
            column(Truck_Rego; "Truck Rego")
            {
            }
            column(ABN_Value; GetABN())
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
        }
        add("Sales Invoice Line")
        {
            column(PickCode; Item."Pick Code")
            {
            }
        }
        modify("Sales Invoice Line")
        {
            trigger OnAfterAfterGetRecord()
            begin
                if Item.Get("No.") then;

            end;
        }
        add(CopyLoop)
        {
            column(CompanyInfo_City; Company_Info.City)
            {
            }
        }
    }
    rendering
    {
        layout("Sales Invoice - D360")
        {
            Type = RDLC;
            LayoutFile = './Rep Ext/Layouts/50854_PFPostedSalesInvoice.rdl';
        }
    }
    trigger OnPreReport()
    begin
        Company_Info.Get();
    end;

    var
        Item: Record Item;
        Company_Info: Record "Company Information";

    local procedure GetABN(): Text
    var
        CompanyInfo: Record "Company Information";
        ABNValue: Code[20];
        ABN: Code[20];
        FirstPart: Text;
        SecondPart: Text;
        ThirdPart: Text;
        ForthPart: Text;
    begin
        // CompanyInfo.Get();
        ABNValue := '50003529575';

        FirstPart := CopyStr(ABNValue, 1, 2);       // First 2 characters
        SecondPart := CopyStr(ABNValue, 3, 3);      // Next 3 characters
        ThirdPart := CopyStr(ABNValue, 6, 3);
        ForthPart := CopyStr(ABNValue, 9);
        // Remaining characters

        exit(FirstPart + ' ' + SecondPart + ' ' + ThirdPart + ' ' + ForthPart);

    end;
}
