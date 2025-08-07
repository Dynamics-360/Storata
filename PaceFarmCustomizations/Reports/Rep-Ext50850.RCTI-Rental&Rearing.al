report 50850 "PF_RCTIRental&Rearing"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = "D360-RCTI Rental & Rearing";

    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.")
            {

            }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {

            }
            column(vendorAddress; vendorAddress)
            {

            }
            column(vendorCity; vendorCity)
            {

            }
            column(vendorCounty; vendorCounty)
            {

            }
            column(vendorPostCode; vendorPostCode)
            {

            }
            column(vendorbank; vendorbank)
            {

            }
            column(VendorAccountNo; VendorAccountNo)
            {

            }
            column(VendorBSB; VendorBSB)
            {

            }
            column(Ship_to_Name; "Ship-to Name")
            {

            }
            column(Vendor_Invoice_No_; "Vendor Invoice No.")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(RCTI_No_; "RCTI No.")
            {

            }
            column(ReportName; ReportName)
            {

            }
            column(ABN; ABN)
            {

            }
            column(TotalAmount; TotalAmount)
            {

            }
            column(GSTText; GSTText)
            {

            }
            column(GSTAmount; GSTAmount)
            {

            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No."),
                                "Document Type" = field("Document Type");
                DataItemTableView = SORTING("Document No.", "Line No.") ORDER(Ascending);
                column(Line_No_; "Line No.")
                {

                }
                column(Description; Description)
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Direct_Unit_Cost; "Direct Unit Cost")
                {

                }
                column(Amount; Amount)
                {

                }
            }
            trigger OnAfterGetRecord()
            var
                VendorRecord: Record Vendor;
                VendorBankAccount: Record "Vendor Bank Account";
                PurchaseLine: Record "Purchase Line";
            begin
                if VendorRecord.get("Buy-from Vendor No.") then begin
                    ABN := VendorRecord."Formatted ABN";
                    vendorAddress := VendorRecord.Address;
                    vendorCity := VendorRecord.City;
                    vendorCounty := VendorRecord.County;
                    vendorPostCode := VendorRecord."Post Code";
                    if (VendorRecord."Preferred Bank Account Code" <> '') then begin
                        if VendorBankAccount.Get("Buy-from Vendor No.", VendorRecord."Preferred Bank Account Code") then begin
                            if VendorBankAccount.Find() then begin
                                vendorbank := VendorBankAccount.Name;
                                VendorAccountNo := VendorBankAccount."Bank Account No.";
                                VendorBSB := VendorBankAccount."Bank Branch No.";
                            end;
                        end;
                    end else if (VendorRecord."EFT Bank Account No." <> '') then begin
                        if VendorBankAccount.Get("Buy-from Vendor No.", VendorRecord."EFT Bank Account No.") then begin
                            if VendorBankAccount.Find() then begin
                                vendorbank := VendorBankAccount.Name;
                                VendorAccountNo := VendorBankAccount."Bank Account No.";
                                VendorBSB := VendorBankAccount."Bank Branch No.";
                            end;
                        end
                    end else begin
                        vendorbank := '';
                        VendorAccountNo := '';
                        VendorBSB := '';
                    end;
                end
                else begin
                    ABN := '';
                    vendorAddress := '';
                    vendorCity := '';
                    vendorCounty := '';
                    vendorPostCode := '';
                end;
                PurchaseLine.SetRange("Document Type", "Document Type");
                PurchaseLine.SetRange("Document No.", "No.");
                PurchaseLine.SetRange(Type, PurchaseLine.Type::"G/L Account");
                if PurchaseLine.FindSet() then begin
                    repeat
                        TotalAmount := PurchaseLine.Amount;
                        if PurchaseLine."VAT %" > 0 then
                            GSTText := 'GST'
                        else
                            GSTText := 'No GST';
                    until PurchaseLine.Next() = 0;
                    if GSTText = 'GST' then
                        GSTAmount := TotalAmount / PurchaseLine."VAT %"
                    else
                        GSTAmount := 0;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(Report; ReportName)
                    {

                    }
                }
            }
        }

    }

    rendering
    {
        layout("D360-RCTI Rental & Rearing")
        {
            Type = RDLC;
            LayoutFile = './Reports/Layouts/50850_PFRCTIrental.rdl';
        }
    }

    var
        ReportName: Option RENTAL,REARING;
        ABN: Text[90];
        TotalAmount: Decimal;
        vendorAddress: Text[100];
        vendorCity: Text[30];
        vendorCounty: Text[30];
        vendorPostCode: Text[20];
        vendorbank: Text[100];
        VendorAccountNo: Text[30];
        VendorBSB: Text[30];
        GSTText: Text[50];
        GSTAmount: Decimal;

}