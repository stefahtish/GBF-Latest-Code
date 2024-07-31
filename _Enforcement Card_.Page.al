page 50943 "Enforcement Card"
{
    Caption = 'Enforcement Card';
    PageType = Card;
    SourceTable = "Enforcement Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = not Rec.Submitted;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Regulatory permit Number"; Rec."License Number")
                {
                    Caption = 'Regulatory permit Number';
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = All;
                }
                field(Volume; Rec.Volume)
                {
                    ApplicationArea = All;
                }
                field("Nature of milk"; Rec."Nature of milk")
                {
                    ApplicationArea = All;
                    Caption = 'Dairy Produce';
                    Visible = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                group("Area of Enforcement")
                {
                    field(Branch; Rec.Branch)
                    {
                        ApplicationArea = All;
                    }
                    field("Sub-County"; Rec."Sub-County")
                    {
                        ApplicationArea = All;
                    }
                    field("Sub-County Name"; Rec."Sub-County Name")
                    {
                        ApplicationArea = All;
                    }
                    // field("County Name"; "County Name")
                    // {
                    //     ApplicationArea = All;
                    // }
                    field(Location; Rec.Location)
                    {
                        ApplicationArea = All;
                    }
                    field("Reasonsforconfiscation"; Rec."Reasons for confiscation")
                    {
                        ApplicationArea = All;
                    }
                }
                field("Personnel Encountered"; Rec."Personnel Encountered")
                {
                    Caption = 'Name of Milk handler';
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    Caption = 'Milk Handler''s ID Number';
                    ApplicationArea = All;
                }
                field("Client Designation"; Rec."Client Designation")
                {
                    Caption = 'Milk Handler''s Designation';
                    ApplicationArea = All;
                }
                // field("Client Name"; Rec."Client Name")
                // {
                //     // ApplicationArea = All;
                //     Caption = 'Name of Owner';
                //     trigger OnValidate()
                //     begin
                //         SetControlAppearance();
                //         CurrPage.Update();
                //     end;
                // }
                field("Means of Handling"; Rec."Means of Handling")
                {
                    Caption = 'Where Found';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                        CurrPage.Update();
                    end;
                }
                field("Modes of handling"; Rec."Modes of handling")
                {
                    Caption = 'Mode';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                        CurrPage.Update();
                    end;
                }
                group(Vehicle)
                {
                    ShowCaption = false;
                    Visible = VehicleVisible;

                    field("Type of Vehicle"; Rec."Type of Vehicle")
                    {
                        Caption = 'Mode of transport';
                        ApplicationArea = All;
                    }
                    field("Vehicle Registrtion Number"; Rec."Vehicle Registrtion Number")
                    {
                        Caption = 'Vehicle Registration Number';
                        ApplicationArea = All;
                    }
                }
                field("Confiscation Officer No"; Rec."Confiscation Officer No")
                {
                    Caption = 'Compliance officer no';
                    Editable = false;
                }
                field("Confiscation Officer Name"; Rec."Confiscation Officer Name")
                {
                    Caption = 'Compliance officer name';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Officer Designation"; Rec."Officer Designation")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Officer's Telephone No."; Rec."Officer's Telephone No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Confiscating Officer"; Rec."Confiscating Officer Signature")
                {
                    Caption = 'Compliance officer signature';
                    ApplicationArea = All;
                }
                field("Confiscation Owner"; Rec."Confiscation Owner")
                {
                    Caption = 'Business Name/Trader';
                    ApplicationArea = All;
                }
                field("Telephone No."; Rec."Telephone No.")
                {
                    Caption = 'Trader''s Telephone No.';
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                }
                field("Trader's Email"; Rec."Trader's Email")
                {
                    ApplicationArea = All;
                }
                field("Huduma Number"; Rec."Huduma Number")
                {
                    Caption = 'Trader''s Huduma Number';
                    ApplicationArea = All;
                }
                field("Confiscation Owner Signature"; Rec."Confiscation Owner Signature")
                {
                    Caption = 'Trader''s Signature';
                    ApplicationArea = All;
                }
                field("Compliance Status"; Rec."Compliance Status")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Submitted; Rec.Submitted)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }
            part("Produce"; "Enforcement Nature of Produce")
            {
                Editable = not Rec.Submitted;
                Caption = 'Dairy Produce';
                SubPageLink = "No." = field("No.");
                UpdatePropagation = Both;
                ApplicationArea = All;
            }
            part("Enforcement NonCompliance"; "Enforcement NonCompliance")
            {
                Editable = not Rec.Submitted;
                Visible = NonCompliance;
                Caption = 'Non compliance';
                SubPageLink = "No." = field("No.");
                UpdatePropagation = Both;
                ApplicationArea = All;
            }
            group("Confiscation Details")
            {
                Visible = Confiscation and Rec.Submitted;

                // ShowCaption = false;
                group(GenDetails)
                {
                    ShowCaption = false;

                    field("Confiscation Name"; Rec."Confiscation Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Confiscation Date"; Rec."Confiscation Date")
                    {
                        ApplicationArea = All;
                    }
                    field("Confiscation Time"; Rec."Confiscation Time")
                    {
                        ApplicationArea = All;
                    }
                    field("Venue"; Rec."Confiscation Venue")
                    {
                        ApplicationArea = All;
                    }
                    field("Any other item seized"; Rec."Any other item seized")
                    {
                        ApplicationArea = All;
                    }
                    field("Books or Records seized"; Rec."Books or Records seized")
                    {
                        ApplicationArea = All;
                    }
                    field("Containers seized"; Rec."Containers seized")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            part("Items Confiscated"; "Items Confiscated Lines")
            {
                SubPageLink = "No." = field("No.");
                UpdatePropagation = both;
                ApplicationArea = All;
                Visible = Confiscation and Rec.Submitted;
            }
            part("Enforcement Lines"; "Enforcement Lines")
            {
                Caption = 'Witnesses';
                Visible = Confiscation and Rec.Submitted;
                SubPageLink = "No." = field("No.");
                UpdatePropagation = both;
                ApplicationArea = All;
            }
            part("Reasons For Confiscation"; "Reasons For Confiscation")
            {
                Visible = Confiscation and Rec.Submitted;
                UpdatePropagation = both;
                SubPageLink = "No." = field("No.");
                ApplicationArea = All;
            }
            group(Disposals)
            {
                Visible = Rec.Submitted;

                field(Disposal; Rec.Disposal)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                group(Prosecution)
                {
                    ShowCaption = false;
                    Visible = Prosecution;

                    field("Judgement Process"; Rec."Judgement Process")
                    {
                        ApplicationArea = All;
                    }
                    field("Disposal Method"; Rec."Disposal Method")
                    {
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            SetControlAppearance();
                            CurrPage.Update();
                        end;
                    }
                }
                group(Certficate)
                {
                    ShowCaption = false;
                    Visible = DisposalCert;

                    field("Disposal Certificate"; Rec."Disposal Certificate")
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Control53; Links)
            {
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("Attachments")
            {
                action("Upload Document")
                {
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Upload documents for the record.';

                    trigger OnAction()
                    var
                    begin
                        //  FromFile := DocumentManagement.UploadDocument(Rec."No.", CurrPage.Caption, Rec.RecordId);
                    end;
                }
            }
            action(Submit)
            {
                Visible = not Rec.Submitted;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ComplianceMgmt: Codeunit "Compliance Management";
                begin
                    ComplianceMgmt.NotifyTrader(Rec);
                    CurrPage.Close();
                end;
            }
            action("Notification")
            {
                Visible = Rec.Submitted;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    EnforcementHeader: Record "Enforcement Header";
                    Jobqueue: Report "Enforcement Notification";
                begin
                    Jobqueue.Run();
                end;
            }
            action("Generate Inspection Order")
            {
                Visible = InspectionOrder and Rec.Submitted;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    EnforcementHeader: Record "Enforcement Header";
                begin
                    EnforcementHeader.RESET;
                    EnforcementHeader.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(Report::InspectionOrder, TRUE, FALSE, EnforcementHeader);
                end;
            }
            action("Generate Confiscation Note")
            {
                Visible = Confiscation and Rec.Submitted;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    EnforcementHeader: Record "Enforcement Header";
                begin
                    EnforcementHeader.RESET;
                    EnforcementHeader.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(Report::ConfiscationNote, TRUE, FALSE, EnforcementHeader);
                end;
            }
            action(Reopen)
            {
                Visible = Rec.Submitted;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.Submitted := false;
                    CurrPage.Close();
                end;
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

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        myInt: Integer;
    begin
        InspectionOrder := false;
        Confiscation := false;
        DisposalCert := false;
    end;

    var
        Confiscation: Boolean;
        Prosecution: Boolean;
        InspectionOrder: Boolean;
        NonCompliance: Boolean;
        VehicleVisible: Boolean;
        VehicleReg: Boolean;
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
        DisposalCert: Boolean;

    procedure SetControlAppearance()
    var
        ECompliance: Record "Enforcement NonCompliance";
        MeansofHandling: Record "Means of Handling Setup";
    begin
        ECompliance.Reset();
        ECompliance.SetRange(Type, ECompliance.Type::General);
        ECompliance.SetRange("No.", Rec."No.");
        ECompliance.setrange("Action To Be Taken", ECompliance."Action To be Taken"::"Given timeline to achieve compliance");
        if ECompliance.FindFirst() then
            InspectionOrder := true
        else
            InspectionOrder := false;
        if Rec.Disposal = Rec.Disposal::"Prosecution Process" then
            Prosecution := true
        else
            Prosecution := false;
        if Rec."Compliance Status" = Rec."Compliance Status"::"Non Compliant" then
            NonCompliance := true
        else
            NonCompliance := false;
        ECompliance.Reset();
        ECompliance.SetRange(Type, ECompliance.Type::General);
        ECompliance.SetRange("No.", Rec."No.");
        ECompliance.setrange("Action To Be Taken", ECompliance."Action To be Taken"::"Proceed to Prosecution");
        if ECompliance.FindFirst() then
            Confiscation := true
        else
            Confiscation := false;
        if Rec."Disposal Method" = Rec."Disposal Method"::Destroyed then
            DisposalCert := true
        else
            DisposalCert := false;
        MeansofHandling.SetRange("Modes of Handling", Rec."Modes of handling");
        MeansofHandling.SetRange("No vehicle registration no", false);
        if MeansofHandling.FindFirst() then
            VehicleReg := true
        else
            VehicleReg := false;
        if (Rec."Means of Handling" = Rec."Means of Handling"::"On Transit") and VehicleReg then
            VehicleVisible := true
        else
            VehicleVisible := false;
    end;
}
