page 51097 "Support Expense Codes"
{
    Caption = 'Capacity building Expense Codes';
    PageType = List;
    SourceTable = "Research Budget";
    SourceTableView = WHERE(Activity = CONST(Stakeholders));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Expense Code"; Rec."Expense Code")
                {
                    ApplicationArea = All;
                }
                field("Source of Funds"; Rec."Source of Funds")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Rec.testfield("Source of Funds");
                    end;
                }
                field("Approved Budget"; Rec."Approved Budget")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Activity := Rec.Activity::Stakeholders;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Activity := Rec.Activity::Stakeholders;
    end;
}
