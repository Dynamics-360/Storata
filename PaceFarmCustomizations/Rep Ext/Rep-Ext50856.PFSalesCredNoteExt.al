reportextension 50856 PFCredNoteExt extends "PF Posted Sales Credit Memo"
{
    dataset
    {
        modify("Sales Cr.Memo Header")
        {
            trigger OnAfterAfterGetRecord()
            var
                SalesInvoiceHeader: Record "Sales Invoice Header";
                CountryRegion: Record "Country/Region";
            begin
                Clear(SalesDoc_Label);
                if "Return Order No." <> '' then
                    SalesDoc_Label := 'Sales Return Order'
                else if "Applies-to Doc. No." <> '' then
                    SalesDoc_Label := 'Sales Order'
                else
                    SalesDoc_Label := 'Sales Order';
                SalesInvoiceHeader.Reset();
                CountryRegion.Reset();
                if SalesInvoiceHeader.Get("Applies-to Doc. No.") then begin
                    PSIShiptoName := SalesInvoiceHeader."Ship-to Name";
                    PSIShiptoname2 := SalesInvoiceHeader."Ship-to Name 2";
                    PSIShiptoAddress := SalesInvoiceHeader."Ship-to Address";
                    PSIShiptoAddress2 := SalesInvoiceHeader."Ship-to Address 2";
                    PSIShiptoCity := SalesInvoiceHeader."Ship-to City";
                    PSIShiptoPostCode := SalesInvoiceHeader."Ship-to Post Code";
                    PSIShiptoCountryRegionCode := SalesInvoiceHeader."Ship-to Country/Region Code";
                    PSIShiptoCounty := SalesInvoiceHeader."Ship-to County";
                    if CountryRegion.Get(PSIShiptoCountryRegionCode) then
                        PSIShiptoCountry := CountryRegion.Name
                    else
                        PSIShiptoCountry := '';
                end
                else begin
                    PSIShiptoName := '';
                    PSIShiptoname2 := '';
                    PSIShiptoAddress := '';
                    PSIShiptoAddress2 := '';
                    PSIShiptoCity := '';
                    PSIShiptoPostCode := '';
                    PSIShiptoCountryRegionCode := '';
                    PSIShiptoCounty := '';
                    PSIShiptoCountry := '';
                end;
            end;
        }
        add("Sales Cr.Memo Header")
        {
            column(Customer_Req; GetOrderNo())
            {
            }
            column(ABN_Value; GetABN())
            {
            }
            column(Return_Order_No_; "Return Order No.")
            {
            }
            column(ReturnOrderBarCode; PacefarmCU.ConvertToBarcode(GetOrderNo()))
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
            column(PSIShiptoname; PSIShiptoname)
            {
            }
            column(PSIShiptoname2; PSIShiptoname2)
            {

            }
            column(PSIShiptoAddress; PSIShiptoAddress)
            {

            }
            column(PSIShiptoAddress2; PSIShiptoAddress2)
            {

            }
            column(PSIShiptoCity; PSIShiptoCity)
            {

            }
            column(PSIShiptoCountry; PSIShiptoCountry)
            {

            }
            column(PSIShiptoCounty; PSIShiptoCounty)
            {

            }
            column(PSIShiptoPostCode; PSIShiptoPostCode)
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
        if ("Sales Cr.Memo Header"."Return Order No." <> '') then
            exit(SalesCredMemHead."Return Order No.")
        else if "Sales Cr.Memo Header"."Applies-to Doc. No." <> '' then
            exit(GetOrderNo)
        else
            exit('');
    end;

    local procedure GetOrderNo(): Text
    var
        SalesInvHead: Record "Sales Invoice Header";
    begin
        if SalesInvHead.Get("Sales Cr.Memo Header"."Applies-to Doc. No.") then begin
            if SalesInvHead."Order No." <> '' then
                exit(SalesInvHead."Order No.")
            else if SalesInvHead."Pre-Assigned No." <> '' then
                exit(SalesInvHead."Pre-Assigned No.")
            else
                exit('');
        end;

    end;

    var
        Company_Info: Record "Company Information";
        SalesDoc_Label: Text;
        SalesDoc_Value: Text;
        PSIShiptoName: Text[100];
        PSIShiptoname2: Text[50];
        PSIShiptoAddress: Text[100];
        PSIShiptoAddress2: Text[50];
        PSIShiptoCity: Text[30];
        PSIShiptoPostCode: Text[20];
        PSIShiptoCountryRegionCode: Code[10];
        PSIShiptoCounty: Text[30];
        PSIShiptoCountry: Text[30];
        PaceFarmCU: Codeunit "Pace Farm Codeunit";
}
