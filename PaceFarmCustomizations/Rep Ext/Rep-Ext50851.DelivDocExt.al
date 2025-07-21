reportextension 50851 DelivDocExt extends "PF Delivery Docket"
{
    dataset
    {
        add(Header)
        {
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(BillToName; "Bill-to Name")
            {
            }
            column(Bill_to_Customer_No_; "Bill-to Customer No.")
            {
            }
            column(SDN; SDN)
            {
            }
            column(Truck_Rego; "Truck Rego")
            {
            }
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            {
            }
            column(ABN_Value; GetABN())
            {
            }
            column(AREmail; AREmail)
            {
            }
            column(GetWorkDescription; GetWorkDescription)
            {
            }
            column(OrderTakenBy; PaceFarmCodeunit.GetUserNameFromSecurityId(Header.SystemCreatedBy))
            {
            }
        }
    }
    rendering
    {
        layout("Delivery Docket - D360")
        {
            Type = RDLC;
            LayoutFile = './Rep Ext/Layouts/50851_PFDeliveryDocket.rdl';
        }
    }
    var
        CompanInfo: Record "Company Information";
        AREmail: Text[100];

    trigger OnPreReport()
    begin
        CompanInfo.Get();
        AREmail := CompanInfo."AR Email";
    end;

    local procedure GetABN(): Text
    var
        ABNValue: Code[20];
        ABN: Code[20];
        FirstPart: Text;
        SecondPart: Text;
        ThirdPart: Text;
        ForthPart: Text;
    begin
        ABNValue := '50003529575';

        FirstPart := CopyStr(ABNValue, 1, 2);       // First 2 characters
        SecondPart := CopyStr(ABNValue, 3, 3);      // Next 3 characters
        ThirdPart := CopyStr(ABNValue, 6, 3);
        ForthPart := CopyStr(ABNValue, 9);
        // Remaining characters

        exit(FirstPart + ' ' + SecondPart + ' ' + ThirdPart + ' ' + ForthPart);
    end;
}
