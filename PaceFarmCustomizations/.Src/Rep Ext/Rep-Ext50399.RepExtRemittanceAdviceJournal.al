// reportextension 50399 RepExtRemittanceAdviceJournal extends "Remittance Advice - Journal"
// {
//     dataset
//     {
//         add("Gen. Journal Line")
//         {
//             column(PostingDate; "Posting Date")
//             {
//             }
//             column(DocumentDate; "Document Date")
//             {
//             }
//             column(PaymentMethod; "Payment Method Code")
//             {
//             }
//             column(CompInfoPicture; CompInfo.Picture)
//             {
//             }
//             column(CompInfoVATRegNo1; CompInfo."VAT Registration No.")
//             {
//             }
//             column(CompInfoGiroNo; CompInfo."Giro No.")
//             {
//             }
//             column(CompInfoBankName1; CompInfo."Bank Name")
//             {
//             }
//             column(CompInfoBankAccountNo; CompInfo."Bank Account No.")
//             {
//             }
//             column(CompInfoName; CompInfo.Name)
//             {
//             }
//             column(CompInfoName2; CompInfo."Name 2")
//             {
//             }
//             column(CompInfoAddress; CompInfo.Address)
//             {
//             }
//             column(CompInfoAddress2; CompInfo."Address 2")
//             {
//             }
//             column(CompInfoCounty; CompInfo.County)
//             {
//             }
//             column(CompInfoFaxNo1; CompInfo."Fax No.")
//             {
//             }
//             column(CompInfoPhoneNo1; CompInfo."Phone No.")
//             {
//             }
//             column(CompInfoPostCode; CompInfo."Post Code")
//             {
//             }
//             column(CompInfoCity; CompInfo."City")
//             {
//             }
//             column(CompInfoCountryRegionCode; CompInfo."Country/Region Code")
//             {
//             }
//             column(CompInfoVATRegsNo; CompInfo."VAT Registration No.")
//             {
//             }
//             column(CompInfoEmail; CompInfo."E-Mail")
//             {
//             }
//             column(CompInfoABN; CompInfo.ABN)
//             {
//             }

//             column(VendorNo; TableVendor."No.")
//             {
//             }
//             column(VendorName; TableVendor.Name)
//             {
//             }
//             column(VendorName2; TableVendor."Name 2")
//             {
//             }
//             column(VendorAddress1; TableVendor.Address)
//             {
//             }
//             column(VendorAddress2; TableVendor."Address 2")
//             {
//             }
//             column(VendorCity; TableVendor.City)
//             {
//             }
//             column(VendorCounty; TableVendor.County)
//             {
//             }
//             column(VendorPostCode; TableVendor."Post Code")
//             {
//             }
//             column(VendorPhoneNo; TableVendor."Phone No.")
//             {
//             }
//             column(VendorFaxNo; TableVendor."Fax No.")
//             {
//             }
//             column(VendorEmail; TableVendor."E-Mail")
//             {
//             }
//             column(VendorBankAccNo; VendorBankAccNo)
//             {
//             }
//             column(VendorBankAccName; VendorBankAccName)
//             {
//             }
//             column(VendorBankBSB; VendorBankBSB)
//             {
//             }
//         }
//         modify("Gen. Journal Line")
//         {
//             trigger OnAfterAfterGetRecord()
//             begin
//                 Clear(VendorBankBSB);
//                 Clear(VendorBankAccNo);
//                 Clear(VendorBankAccName);
//                 if "Account Type" = "Account Type"::Vendor then begin
//                     if TableVendor.Get("Account No.") then begin
//                         VendorBankAccount.Reset;
//                         VendorBankAccount.Setrange(VendorBankAccount."Vendor No.", TableVendor."No.");
//                         VendorBankAccount.Setrange(VendorBankAccount.Code, TableVendor."EFT Bank Account No.");
//                         if VendorBankAccount.FindSet() then begin
//                             VendorBankBSB := VendorBankAccount."EFT BSB No.";
//                             VendorBankAccNo := VendorBankAccount."Bank Account No.";
//                             VendorBankAccName := VendorBankAccount.Name;
//                         end;
//                     end;
//                 end;
//             end;
//         }
//         add(PrintLoop)
//         {
//             column(AppliedVendLedgEntryTempDiscount; TempAppliedVendLedgEntry."Pmt. Disc. Rcd.(LCY)")
//             {
//             }
//         }
//     }
//     rendering
//     {
//         layout("Remittance Advice Journal")
//         {
//             Type = RDLC;
//             Caption = 'Pace Farm - Remittance Advice Journal';
//             Summary = 'Pace Farm - Remittance Advice Journal';
//             LayoutFile = '03.Report\Rep-Ext50399.RepExtRemittanceAdviceJournal.rdl';
//         }
//     }
//     trigger OnPreReport()
//     begin
//         CompInfo.Get;
//         CompInfo.CalcFields(CompInfo.Picture);
//     end;

//     var
//         CompInfo: Record "Company Information";
//         TableVendor: Record Vendor;
//         VendorBankAccount: Record "Vendor Bank Account";
//         VendorBankBSB: Text;
//         VendorBankAccNo: Text;
//         VendorBankAccName: Text;
// }
