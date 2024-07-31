page 50623 "Company Job Prof course"
{
    Caption = 'Company Job Professional course';
    PageType = ListPart;
    SourceTable = "Company Job Education";
    SourceTableView = where("Education Level" = filter(Professional));
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Qualification Code"; Rec."Qualification Code Prof")
                {
                    ApplicationArea = All;
                }
                field("Qualification Name"; Rec."Qualification Name")
                {
                    ApplicationArea = All;
                }
                field("Section/Level"; Rec."Section/Level")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Education Level" := Rec."Education Level"::Professional;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Education Level" := Rec."Education Level"::Professional;
    end;
}
