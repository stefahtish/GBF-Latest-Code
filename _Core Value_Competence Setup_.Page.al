page 50732 "Core Value/Competence Setup"
{
    ApplicationArea = All;
    Caption = 'Core Value/Competence Setup';
    PageType = List;
    SourceTable = "Core Values/Competences setup";
    UsageCategory = Administration;
    SourceTableView = where(Type=const("Core Values/Competence"));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("SNo."; Rec."SNo.")
                {
                    ToolTip = 'Specifies the value of the SNo. field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    var
        myInt: Integer;
    begin
        Rec.Type:=Rec.Type::"Core Values/Competence";
    end;
}
