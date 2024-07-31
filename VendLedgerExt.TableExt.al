tableextension 50157 VendLedgerExt extends "Vendor Ledger Entry"
{
    fields
    {
        modify("Applies-to ID")
        {
        trigger OnAfterValidate()
        begin
            if "Applies-to ID" <> '' then begin
                if "Applies-to ID" <> xRec."Appl. To ID Copy" then "Appl. To ID Copy":="Applies-to ID";
            end;
        end;
        }
        field(50000; "Appl. To ID Copy"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Funding Transaction Type";enum "Funding Transaction Type")
        {
        }
        field(50002; "Fund No."; Code[20])
        {
        }
        field(50003; "Bond Application No."; Code[20])
        {
        }
        field(50004; "Issue No."; Code[20])
        {
        }
    }
    keys
    {
    }
}
