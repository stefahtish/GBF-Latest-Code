tableextension 50141 "Item Jnl Batch Ext" extends "Item Journal Batch"
{
    fields
    {
        field(50000; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Document No." <> xRec."Document No." then NoSeriesMgt.TestManual(CashMgmt."Item Journal Nos");
            end;
        }
        field(50001; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,Pending,Released,Rejected;
        }
    }
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CashMgmt: Record "Cash Management Setups";

    trigger OnAfterInsert()
    var
        myInt: Integer;
    begin
        CashMgmt.Get;
        NoSeriesMgt.InitSeries(CashMgmt."Item Journal Nos", xRec."No. Series", 0D, "Document No.", "No. Series");
    end;
}
