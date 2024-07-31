page 51107 "Sample Results List"
{
    Caption = 'Sample Results List';
    PageType = List;
    Editable = false;
    CardPageId = "Sample Results Card";
    SourceTable = "Sample analysis and reporting";
    SourceTableView = where("Submit results" = const(true));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Analysis No."; Rec."Analysis No.")
                {
                    ApplicationArea = All;
                }
                field("Sample temperature"; Rec."Sample temperature")
                {
                    ApplicationArea = All;
                }
                field("Testing date"; Rec."Testing date")
                {
                    ApplicationArea = All;
                }
                field("Testing officer"; Rec."Testing officer")
                {
                    ApplicationArea = All;
                }
                field("Lab section received"; Rec."Lab section received")
                {
                    ApplicationArea = All;
                }
                field(Results; Rec.Results)
                {
                    ApplicationArea = All;
                }
                field("Results date"; Rec."Results date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        Rec.CalcFields("Can be done", "Cannot be done");
        if Rec."Can be done" > 0 then begin
            if Rec."Can be done" = Rec."Cannot be done" then Rec."Submit results" := true;
        end;
    end;
}
