page 50235 "FA Disposal Quote Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Suppliers,Tasks';
    SourceTable = "Procurement Request";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("FA Disposal No."; Rec."FA Disposal No.")
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Editable = false;
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                        CurrPage.Update();
                    end;
                }
                group(New)
                {
                    ShowCaption = false;
                    Visible = New;

                    field("Prospect No"; Rec."Prospect No")
                    {
                    }
                }
                group(Existing)
                {
                    ShowCaption = false;
                    Visible = Existing;

                    field("Customer No."; Rec."Customer No.")
                    {
                    }
                }
                group(Staff)
                {
                    ShowCaption = false;
                    Visible = Staff;

                    field("Employee No."; Rec."Employee No.")
                    {
                    }
                }
                field("Customer Name"; Rec."Customer Name")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    Visible = false;
                }
            }
            part("ProcLines"; "FA Disposal Quote Lines")
            {
                SubPageLink = "Requisition No" = FIELD("No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Submit Bid")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                image = UnitConversions;

                trigger OnAction()
                var
                    FADispLines: Record "Procurement Request Lines";
                begin
                    if Confirm('Are you sure?', false) then begin
                        FADispLines.Reset();
                        FADispLines.SetRange("Requisition No", Rec."No.");
                        if FADispLines.FindSet(false, false) then
                            repeat
                                FADispLines."Bid Submitted" := true;
                                FADispLines.Modify();
                            until FADispLines.Next() = 0;
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify();
                        Message('Bid submitted successfully');
                        CurrPage.Close();
                    end;
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Process Type" := Rec."Process Type"::"FA Disposal Quote";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Process Type" := Rec."Process Type"::"FA Disposal Quote";
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SetControlAppearance();
    end;

    var
        ProcurementManagement: Codeunit "Procurement Management";
        SupplierSelect: Record "Supplier Selection";
        New: Boolean;
        Existing: Boolean;
        Staff: Boolean;

    local procedure TestTheFields()
    begin
        Rec.TestField("Requisition No");
        Rec.TestField(Title);
    end;

    procedure SetControlAppearance()
    begin
        if Rec."Customer Type" = Rec."Customer Type"::New then
            New := true
        else
            New := false;
        if Rec."Customer Type" = Rec."Customer Type"::Existing then
            Existing := true
        else
            Existing := false;
        if Rec."Customer Type" = Rec."Customer Type"::Staff then
            Staff := true
        else
            Staff := false;
    end;
}
