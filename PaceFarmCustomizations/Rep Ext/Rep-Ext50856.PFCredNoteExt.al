reportextension 50856 PFCredNoteExt extends "PF Posted Sales Credit Memo"
{
    dataset
    {
        modify("Sales Cr.Memo Header")
        {
            trigger OnAfterAfterGetRecord()
            begin
                Clear(SalesDoc_Label);
                if "Applies-to Doc. No." <> '' then
                    SalesDoc_Label := 'Sales Order'
                else if "Return Order No." <> '' then
                    SalesDoc_Label := 'Sales Return Order';
            end;
        }
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
            column(Payment_Terms_Code; "Payment Terms Code")
            {

            }
            column(Applies_to_Doc__No_; "Applies-to Doc. No.")
            {

            }
            column(SalesDocValue; GetSalesDocValue("Sales Cr.Memo Header"))
            {
            }
            column(SalesDocLabel; SalesDoc_Label)
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
        add(CopyLoop)
        {
            column(CompanyInfo_City; Company_Info.City)
            {
            }
        }
    }
    rendering
    {
        layout("Sales Credit Memo - D360")
        {
            Type = RDLC;
            LayoutFile = './Rep Ext/Layouts/50856_PFSalesCreditMemo.rdl';
        }
    }
    trigger OnPreReport()
    begin
        Company_Info.Get();
    end;

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

    local procedure GetSalesDocValue(SalesCredMemHead: Record "Sales Cr.Memo Header"): Text
    begin
        if "Sales Cr.Memo Header"."Applies-to Doc. No." <> '' then
            exit(GetOrderNo)
        else if "Sales Cr.Memo Header"."Return Order No." <> '' then
            exit(SalesCredMemHead."Return Order No.")
        else
            exit('');
    end;

    local procedure GetOrderNo(): Text
    var
        SalesInvHead: Record "Sales Invoice Header";
    begin
        if SalesInvHead.Get("Sales Cr.Memo Header"."Applies-to Doc. No.") then
            exit(SalesInvHead."Order No.")
        else
            exit('');
    end;

    var
        Company_Info: Record "Company Information";
        SalesDoc_Label: Text;
        SalesDoc_Value: Text;
}
