reportextension 50856 PFCredNoteExt extends "PF Posted Sales Credit Memo"
{
    dataset
    {
        add("Sales Cr.Memo Header")
        {
            column(ABN_Value; GetABN())
            {
            }
            column(SDN; SDN)
            {
            }
            column(Truck_Rego; "Truck Rego")
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {

            }
        }
        add("Sales Cr.Memo Line")
        {
            column(AmountNegative; -Amount)
            {

            }
            column(Unit_Price_Negative; "Unit Price")
            {

            }
        }
    }
    rendering
    {
        layout("SalesCreditMemo - D360")
        {
            Type = RDLC;
            LayoutFile = './SalesCreditMemoModified.rdl';
        }
    }
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
