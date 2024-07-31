page 50976 "Sample Conditions Lab Lines"
{
    Caption = 'Sample Condition';
    PageType = ListPart;
    SourceTable = "Sample Conditions Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Reception';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Lab; Rec.Lab)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Additional Information"; Rec."Additional Information")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Batch Number"; Rec."Batch Number")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Expiry date needed"; Rec."Expiry date needed")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Batch Number needed"; Rec."Batch Number needed")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Explanation Needed"; Rec."Explanation Needed")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance;
    end;

    var
        ExpiryDate: Boolean;
        BatchNo: Boolean;
        Explanation: Boolean;

    procedure SetControlAppearance()
    var
        myInt: Integer;
    begin
        if Rec."Expiry date needed" = true then
            ExpiryDate := true
        else
            ExpiryDate := false;
        if Rec."Batch Number needed" = true then
            BatchNo := true
        else
            BatchNo := false;
        if Rec."Explanation Needed" = true then
            Explanation := true
        else
            Explanation := false;
    end;
}
