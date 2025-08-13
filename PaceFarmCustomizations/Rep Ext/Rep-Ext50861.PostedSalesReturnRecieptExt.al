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
                ShipCountryRegion: Record "Country/Region";
                SalesInvoiceHeader: Record "Sales Invoice Header";
                Supervisor: Record "Warehouse Supervisor";
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

                If ShipCountryRegion.get("Ship-to Country/Region Code") then
                    Shiptocountry := CountryRegion.Name
                else
                    Shiptocountry := '';
                SalesInvoiceHeader.Reset();
                ShipCountryRegion.Reset();
                if SalesInvoiceHeader.Get("Applies-to Doc. No.") then begin
                    PSIShiptoName := SalesInvoiceHeader."Ship-to Name";
                    PSIShiptoname2 := SalesInvoiceHeader."Ship-to Name 2";
                    PSIShiptoAddress := SalesInvoiceHeader."Ship-to Address";
                    PSIShiptoAddress2 := SalesInvoiceHeader."Ship-to Address 2";
                    PSIShiptoCity := SalesInvoiceHeader."Ship-to City";
                    PSIShiptoPostCode := SalesInvoiceHeader."Ship-to Post Code";
                    PSIShiptoCountryRegionCode := SalesInvoiceHeader."Ship-to Country/Region Code";
                    PSIShiptoCounty := SalesInvoiceHeader."Ship-to County";
                    Run_No := SalesInvoiceHeader."Run No.";
                    if ShipCountryRegion.Get(PSIShiptoCountryRegionCode) then
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
                    Run_No := '';
                end;

                if Supervisor.Get("Warehouse Supervisor") then
                    SupervisorName := Supervisor."Supervisor Name"
                else
                    SupervisorName := '';
            end;
        }
        add("Return Receipt Header")
        {
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
            column(Ship_to_Name; "Ship-to Name")
            {

            }
            column(Ship_to_Country; Shiptocountry)
            {

            }
            column(Ship_to_Address; "Ship-to Address")
            {

            }
            column(Ship_to_Address_2; "Ship-to Address 2")
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
            column(WorkDesc; PFEventMgt.GetWorkDescription("Return Receipt Header"))
            {

            }
            column(Store_Man; "Store Man")
            {

            }
            column(Carrier; Carrier)
            {

            }
            column(Driver; Driver)
            {

            }
            column(Run_No; Run_No)
            {

            }
            column(Document_Date; "Document Date")
            {

            }
            column(Product; Product)
            {

            }
            column(Product_Relv__Temp_; "Product Relv. Temp.")
            {

            }
            column(Date_Produced_UBD; "Date Produced/UBD")
            {

            }
            column(Reason_Code; "Reason Code")
            {

            }
            column(Reason_for_Return_Comment; "Reason for Return Comment")
            {

            }
            column(Warehouse_Supervisor; SupervisorName)
            {

            }
            column(Supervisor; "Warehouse Supervisor")
            {

            }
            column(Warehouse_Handling_Time; "Warehouse Handling Time")
            {

            }
            column(Action_Taken; "Action Taken")
            {

            }
            column(Action_Take_Comment; "Action Take Comment")
            {

            }
            column(Run_No_; "Run No.")
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
            column(Type; Type)
            {

            }
            column(Condition_on_Arrival; "Condition on Arrival")
            {

            }
            column(Condition_Comment; "Condition Comment")
            {

            }

        }
    }

    rendering
    {
        layout("Sals Return Receipt - D360")
        {
            Type = RDLC;
            LayoutFile = './Rep Ext/Layouts/50861_PFSalesReturnReceipt.rdl';
        }
        layout("Sals Return Receipt updated- D360")
        {
            Type = RDLC;
            LayoutFile = './Rep Ext/Layouts/50861_PFSalesReturnReceiptUpdated.rdl';
        }
    }
    var
        PaceFarmCodeunit: Codeunit "Pace Farm Codeunit";
        PFEventMgt: Codeunit "PF_EventMgt";
        Company: Record "Company Information";
        PaymentDescription: Text[100];
        totalamountSR: Decimal;
        Billtocountry: Text[100];
        Shiptocountry: Text[100];
        PSIShiptoName: Text[100];
        PSIShiptoname2: Text[50];
        PSIShiptoAddress: Text[100];
        PSIShiptoAddress2: Text[50];
        PSIShiptoCity: Text[30];
        PSIShiptoPostCode: Text[20];
        PSIShiptoCountryRegionCode: Code[10];
        PSIShiptoCounty: Text[30];
        PSIShiptoCountry: Text[30];
        Run_No: Code[20];
        SupervisorName: Text[100];


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