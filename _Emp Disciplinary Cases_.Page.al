page 50405 "Emp Disciplinary Cases"
{
    PageType = ListPart;
    SourceTable = "Employee Disciplinary Cases";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Reference No"; Rec."Refference No")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Disciplinary Case"; Rec."Disciplinary Case")
                {
                    Visible = true;
                }
                field("Case Description"; Rec."Case Description")
                {
                    Editable = false;
                }
                field(Hearing; Rec.Hearing)
                {
                    Caption = 'Define the case';
                }
                field(Capability; Rec.Capability)
                {
                    Visible = false;
                }
                field("Accused Defence"; Rec."Accused Defence")
                {
                    Caption = 'Accused witness';
                }
                field("Witness Type"; Rec."Witness Type")
                {
                    trigger OnValidate()
                    begin
                        ShowStaffWitness;
                    end;
                }
                field("Witness #1"; Rec."Witness #1")
                {
                    Caption = 'Witness Employee';
                }
                field("Witness Name"; Rec."Witness Name")
                {
                }
                field("Witness #2"; Rec."Witness #2")
                {
                    Caption = 'Other Witness';
                }
                field(Defense; Rec.Defense)
                {
                }
                field("RecAction Description"; Rec."RecAction Description")
                {
                    Caption = 'Outcome of defense';
                }
                field("Recommended Action"; Rec."Recommended Action")
                {
                }
                field("Action Taken"; Rec."Action Taken")
                {
                }
                field("Action Description"; Rec."Action Description")
                {
                    Editable = false;
                }
                field("Date Taken"; Rec."Date Taken")
                {
                }
                field("Disciplinary Remarks"; Rec."Disciplinary Remarks")
                {
                }
                field(Comments; Rec.Comments)
                {
                }
                field(Attachment; Rec.Attachment)
                {
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    Visible = false;
                }
                field("Cases Discusion"; Rec."Cases Discusion")
                {
                    Visible = false;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        ShowStaffWitness;
    end;

    trigger OnOpenPage()
    begin
        ShowStaffWitness;
    end;

    var
        Staff: Boolean;

    local procedure ShowStaffWitness()
    begin
        if Rec."Witness Type" = Rec."Witness Type"::Staff then begin
            Staff := false;
        end
        else
            Staff := true;
    end;
}
