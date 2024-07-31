page 51086 "Sample Ret Condition Lines"
{
    Caption = 'Sample Retention Conditions';
    PageType = ListPart;
    SourceTable = "Sample Ret Conditions Line";
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

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        SetRetentionView
                    end;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Degree Celsius';
                    ApplicationArea = All;
                }
                field("Retention period"; Rec."Retention period")
                {
                    Visible = RetPeriod;
                }
                field(Option; Rec.Option)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetRetentionView();
    end;

    var
        RetPeriod: Boolean;

    procedure SetRetentionView()
    var
        RetConditions: record "Laboratory Setup Type";
    begin
        RetConditions.Reset();
        RetConditions.SetRange(Type, RetConditions.Type::"Sample Retention Conditions");
        RetConditions.SetRange(Name, Rec.Code);
        RetConditions.SetRange("Is Retention Period", true);
        if RetConditions.Find('-') then
            RetPeriod := true
        else
            RetPeriod := false;
    end;
}
