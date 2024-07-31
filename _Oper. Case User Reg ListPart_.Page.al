page 50873 "Oper. Case User Reg ListPart"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "User Setup";
    SourceTableView = WHERE("Case Handler" = FILTER(true));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater("Cases Assigned")
            {
                field("User ID"; Rec."User ID")
                {
                }
                field("No of Active Cases"; NoOfActiveCases)
                {
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        // CustomerCard.OPENVIEW;
                        // CustomerCard.TRAP;
                        // //CustomerCard."Page Customer Statistics".INVOKE;
                    end;
                }
                field(Assigned; Rec."Active Registry Cases")
                {
                    ToolTip = 'These are the Total Number of Cases a User has been assigned in this Company';
                    Visible = IsRegistryAssign;
                }
                field("Assigned "; Rec."Active Assigned Cases")
                {
                    ToolTip = 'These are the Total Number of Cases a User has been assigned in this Company';
                    Visible = NOT IsRegistryAssign;
                }
                field("Tot. Company"; Rec."Temp Active Cases")
                {
                    ToolTip = 'These are the Total Number of Cases a User has been assigned in All Companies';
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        IsRegistryAssign := FieldVisibleFunction;
    end;

    var
        CustomerCard: TestPage "Customer Card";
        NoOfActiveCases: Integer;
        IsRegistryAssign: Boolean;
        CRMSetup: Record "Interaction Setup";

    local procedure FieldVisibleFunction(): Boolean
    begin
        CRMSetup.Get;
        IsRegistryAssign := CRMSetup."Auto Assign on Registry";
    end;
}
