reportextension 50861 PostedSalesReturnReciept extends "Sales - Return Receipt"
{
    dataset
    {
        modify("Return Receipt Header")
        {
            trigger OnAfterAfterGetRecord()
            var
                Paymentterms: Record "Payment Terms";
                ReturnReceiptLine: Record "Return Receipt Line";
                CountryRegion: Record "Country/Region";
            begin
                Paymentterms.Reset();
                if Paymentterms.Get("Payment Terms Code") then
                    PaymentDescription := Paymentterms.Description
                else
                    PaymentDescription := "Payment Terms Code";
                ReturnReceiptLine.Reset();
                totalamountSR := 0;
                ReturnReceiptLine.SetRange("Document No.", "No.");
                If ReturnReceiptLine.FindSet() then begin
                    repeat
                        totalamountSR := totalamountSR + ReturnReceiptLine."Item Charge Base Amount";
                    until ReturnReceiptLine.Next() = 0;
                end;
                If CountryRegion.get("Bill-to Country/Region Code") then
                    Billtocountry := CountryRegion.Name
                else
                    Billtocountry := '';
            end;
        }
        add("Return Receipt Header")
        {
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {

            }
            column(Applies_to_Doc__No_; "Applies-to Doc. No.")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(Payment_Terms_Code; "Payment Terms Code")
            {

            }
            column(Return_Order_No_; "Return Order No.")
            {

            }
            column(Posting_Description; "Posting Description")
            {

            }
            column(Bill_to_Customer_No_; "Bill-to Customer No.")
            {

            }
            column(External_Document_No_; "External Document No.")
            {

            }
            column(ABN; GetABN())
            {

            }
            column(SDN; SDN)
            {

            }
            column(Truck_Rego; "Truck Rego")
            {

            }
            column(Company_Picture; Company.Picture)
            {

            }
            column(Payment_Terms_Desc; PaymentDescription)
            {

            }
            column(Due_Date; "Due Date")
            {

            }
            column(Ship_to_City; "Ship-to City")
            {

            }
            column(Ship_to_Post_Code; "Ship-to Post Code")
            {

            }
            column(Ship_to_County; "Ship-to County")
            {

            }
            column(Bill_to_Name; "Bill-to Name")
            {

            }
            column(Bill_to_Address; "Bill-to Address")
            {

            }
            column(Bill_to_City; "Bill-to City")
            {

            }
            column(Bill_to_County; "Bill-to County")
            {

            }
            column(Bill_to_Post_Code; "Bill-to Post Code")
            {

            }
            column(Bill_to_country; Billtocountry)
            {

            }
            column(totalamount; -totalamountSR)
            {

            }
            column(Amount; totalamountSR)
            {

            }
        }
        add(CopyLoop)
        {
            column(OrderTakenBy; PaceFarmCodeunit.GetUserNameFromSecurityId("Return Receipt Header".SystemCreatedBy))
            {
            }
            column(OrderNoBarcodeText; PaceFarmCodeunit.ConvertToBarcode("Return Receipt Header"."Return Order No."))
            {
            }
        }
        add("Return Receipt Line")
        {
            column(Unit_Price; "Unit Price")
            {

            }
            column(Line_Discount__; "Line Discount %")
            {

            }
            column(VAT_Base_Amount; -"Item Charge Base Amount")
            {

            }

        }
    }

    rendering
    {
        layout(D360SalesReturnReciept)
        {
            Type = RDLC;
            LayoutFile = 'D360-SalesReturnReceipt.rdl';
        }
    }
    var
        PaceFarmCodeunit: Codeunit "Pace Farm Codeunit";
        Company: Record "Company Information";
        PaymentDescription: Text[100];
        totalamountSR: Decimal;
        Billtocountry: Text[100];


    trigger OnPreReport()
    var
        CompanyInfo: Record "Company Information";
    begin
        if CompanyInfo.Get() then begin
            CompanyInfo.CalcFields(Picture);
            Company.Picture := CompanyInfo.Picture;
        end;
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
}