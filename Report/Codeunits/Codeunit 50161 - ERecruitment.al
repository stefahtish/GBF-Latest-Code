codeunit 50161 ERecruitment
{
    Permissions = tabledata 454 = RIMD;

    // trigger OnRun()
    // begin
    //  Message(FnCreateRegistration('12345678', 'Steve', 'Mutinda', 'Mbisu', 'mmbisu@brightpointinfotech.com', '0720000000'));    
    // end;

    [ServiceEnabled]
    procedure FnCreateRegistration(idNumber: Text; firstName: Text; lastName: Text; middleName: Text; eMail: Text[400]; phoneNumber: Text) RetV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not CreateRegistration(idNumber, firstName, lastName, middleName, eMail, phoneNumber) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RetV);
    end;

    [TryFunction]
    procedure CreateRegistration(idnumber: Text; firstname: Text; lastname: Text; middlename: Text; email: Text[400]; phoneNumber: Text)
    var
        PortalUSer: Record "Portal User";
        RandomDigit: Text[50];
    begin
        OnlineApplicants.Reset;
        OnlineApplicants.SetRange("E-Mail", email);
        if OnlineApplicants.Find('-') then begin
            Error('Oops! it seems you have already registred with the email. Kindly login using your email and the password you set during registration or reset your password.');
        end
        else begin
            RandomDigit := CreateGuid;
            RandomDigit := DelChr(RandomDigit, '=', '{}-01');
            RandomDigit := CopyStr(RandomDigit, 1, 8);
            OnlineApplicants."E-Mail" := email;
            OnlineApplicants."ID Number" := idnumber;
            OnlineApplicants."Last Name" := lastname;
            OnlineApplicants."First Name" := firstname;
            OnlineApplicants."Middle Name" := middlename;
            OnlineApplicants."Home Phone Number" := phoneNumber;
            OnlineApplicants.Password := RandomDigit;
            OnlineApplicants."Application Date" := Today;
            if OnlineApplicants.Insert(true) then begin
                // Update Portal user;
                //  PortalUSer.Reset;
                //  PortalUSer.SetRange("Authentication Email", email);
                //  if not PortalUSer.FindSet then begin
                //      PortalUSer.Init;
                //      PortalUSer."User Name" := OnlineApplicants."First Name" + ' ' + OnlineApplicants."Middle Name" + ' ' + OnlineApplicants."Last Name";
                //      PortalUSer."Full Name" := OnlineApplicants."First Name" + ' ' + OnlineApplicants."Middle Name" + ' ' + OnlineApplicants."Last Name";
                //      PortalUSer."Authentication Email" := OnlineApplicants."E-Mail";
                //      PortalUSer."Mobile Phone No." := OnlineApplicants."Home Phone Number";
                //      PortalUSer.State := PortalUSer.State::Enabled;
                //      PortalUSer."Record Type" := PortalUSer."record type"::"Job Applicant";
                //      PortalUSer."Record ID" := OnlineApplicants."No.";
                //      PortalUSer."Password Value" := RandomDigit;
                //      PortalUSer."Last Modified Date" := Today;
                //      if PortalUSer.Insert(true) then begin
                FnSendEmaiNotificationOnApplicantAccountActivation(OnlineApplicants);
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('Message', 'Your account has been created successfully');
                //      end;
                //  end
                //  else begin
                //      Error('Oops! it seems you have already registred with the email on the portal users. Kindly login using your email and the password you set during registration or reset your password.');

                //  end;
            end;
        end;
    end;

    [ServiceEnabled]
    procedure ApplicantForgotPassword(email: Text; randoValue: Text[20]) RetV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not SubmitApplicantForgotPasswordRandom(email, randoValue) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RetV);
    end;

    [TryFunction]
    procedure SubmitApplicantForgotPasswordRandom(email: Text; RandoValue: Text[20])
    begin
        OnlineApplicants.RESET;
        OnlineApplicants.SETRANGE("E-Mail", email);
        IF OnlineApplicants.FIND('-') THEN BEGIN
            OnlineApplicants.TestField("E-Mail");
            OnlineApplicants."Random Value" := RandoValue;
            OnlineApplicants."Code Used" := FALSE;
            OnlineApplicants."Changed Password" := false;
            OnlineApplicants.MODIFY;
            JsObject.Add('Error', 'FALSE');
            JsObject.Add('Applicant_Name', OnlineApplicants."Last Name" + ' ' + OnlineApplicants."Middle Name");
        end ELSE
            ERROR('Registration Number does not exist.');
    end;

    [ServiceEnabled]
    procedure UpdateApplicantPassword(email: Text; pwd: Text) RetV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not UpdateApplicantNewPassword(email, pwd) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RetV);
    end;

    [TryFunction]
    procedure UpdateApplicantNewPassword(email: Text; pwd: Text)
    begin
        OnlineApplicants.RESET;
        OnlineApplicants.SETRANGE("E-Mail", email);
        IF OnlineApplicants.FIND('-') THEN BEGIN
            OnlineApplicants.Password := pwd;
            OnlineApplicants."Changed Password" := true;
            OnlineApplicants."Code Used" := true;
            OnlineApplicants.modify;
            JsObject.Add('Error', 'FALSE');
        end;
    end;

    [ServiceEnabled]
    procedure FnChangeCandidatePassword(emailaddress: Text; currentPassword: Text; newPassword: Text; confirmNewPassword: Text) RetV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not ChangeCandidatePassword(emailaddress, currentPassword, newPassword, confirmNewPassword) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RetV);
    end;

    [TryFunction]
    procedure ChangeCandidatePassword(emailaddress: Text; currentPassword: Text; newPassword: Text; confirmNewPassword: Text)
    var
        PortalUser: Record "Portal User";
    begin

        PortalUser.Reset;
        PortalUser.SetRange("Authentication Email", emailaddress);
        if PortalUser.FindSet then begin
            if PortalUser."Password Value" = currentPassword then begin
                if newPassword = confirmNewPassword then begin
                    PortalUser."Password Value" := newPassword;
                    PortalUser."Change Password" := true;
                    PortalUser."Last Modified Date" := Today;
                    if PortalUser.Modify(true) then begin
                        JsObject.Add('Error', 'FALSE');
                        JsObject.Add('Message', 'Your password was successfully changed');
                    end else begin
                        Error('Your password could not be reset');
                    end;
                end else begin
                    Error('New password and Confirmed new password do not match');
                end;
            end else begin
                Error('Wrong current password.Kindly Ensure that the Current Password is Correct');
            end;
        end else begin
            Error('The specified Email Address does not exist');
        end;
    end;


    [ServiceEnabled]
    procedure SendEmail(receiver: Text[130]; subject: Text; message: Text) RetV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not SubmitSendEmail(receiver, subject, message) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RetV);
    end;

    [TryFunction]
    procedure SubmitSendEmail(receiver: Text[130]; subject: Text; message: Text)
    var
        SMTPMail: Codeunit "Email Message";
        SendEmail: codeunit email;
        SendToList: List of [Text];
    begin
        if receiver <> '' then begin
            Clear(SendToList);
            SendToList.Add(receiver);
            SMTPMail.Create(SendToList, Subject, message, true);
            SendEmail.Send(SMTPMail, Enum::"Email Scenario"::Default);
            JsObject.Add('Error', 'FALSE');
        end;
    end;

    [ServiceEnabled]
    procedure FnApplicantProfileRegistration(applicantNumber: Text; surname: Text; firstname: Text; othernames: Text; gender: Integer; idnumber: Text; passportnumber: Text; nationality: Text; countryoforigin: Text; ethnicity: Text; mobilephonenumber: Text; krapin: Text; maritalstatus: Integer; address: Code[50]; disabilitysummary: Text[50]; phonenumber2: Text; isdisable: Boolean) RetV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not ApplicantProfileRegistration(applicantNumber, surname, firstname, othernames, gender, idnumber, passportnumber, nationality, countryoforigin, ethnicity, mobilephonenumber, krapin, maritalstatus, address, disabilitysummary, phonenumber2, isdisable) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RetV);
    end;

    [TryFunction]

    procedure ApplicantProfileRegistration(applicantNumber: Text; surname: Text; firstname: Text; othernames: Text; gender: Integer; idnumber: Text; passportnumber: Text; nationality: Text; countryoforigin: Text; ethnicity: Text; mobilephonenumber: Text; krapin: Text; maritalstatus: Integer; address: Code[50]; disabilitysummary: Text[50]; phonenumber2: Text; isdisable: Boolean)
    var
        Applicant: Record Applicants2;
    begin


        Applicant.Reset;
        Applicant.SetRange("No.", applicantNumber);
        if Applicant.FindSet then begin
            // Applicant."First Name" := firstname;
            // Applicant."Middle Name" := othernames;
            // Applicant."Last Name" := surname;
            Applicant.Gender := gender;
            Applicant."Marital Status" := maritalstatus;
            Applicant."ID Number" := idnumber;
            // Applicant."Date Of Birth" := dateofbirth;
            //  Applicant.Validate("Date Of Birth");
            Applicant."Country Code" := countryoforigin;
            Applicant.Citizenship := nationality;
            Applicant."Home Phone Number" := phonenumber2;
            Applicant."PIN Number" := krapin;
            Applicant."Postal Address" := address;
            Applicant."Cellular Phone Number" := mobilephonenumber;
            if (isdisable = true) then begin
                Applicant.Disabled := Applicant.Disabled::Yes;
                Applicant."Disabling Details" := disabilitysummary;
            end;
            if Applicant.Modify(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('Message', 'Your Aplicant account was successfully created. Please proceed to complete your profile!');
            end else begin
                Error('Your Aplicant account was not created successfully.Kindly Contact System Administrator');
            end;
        end else begin
            Applicant.Init;
            // Applicant."First Name" := firstname;
            // Applicant."Middle Name" := othernames;
            //Applicant."Last Name" := surname;
            Applicant.Gender := gender;
            Applicant."Marital Status" := maritalstatus;
            Applicant."ID Number" := idnumber;
            // Applicant."Date Of Birth" := dateofbirth;
            //  Applicant.Validate("Date Of Birth");
            Applicant."Country Code" := countryoforigin;
            Applicant.Citizenship := nationality;
            Applicant."Home Phone Number" := phonenumber2;
            Applicant."PIN Number" := krapin;
            Applicant."Postal Address" := address;
            Applicant."Cellular Phone Number" := mobilephonenumber;

            if (isdisable = true) then begin
                Applicant.Disabled := Applicant.Disabled::Yes;
                Applicant."Disabling Details" := disabilitysummary;
            end;
            if Applicant.Insert(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('Message', 'Your Aplicant account was successfully created. Please proceed to complete your profile!');
            end else begin
                Error('Your Aplicant account was not created successfully.Kindly Contact System Administrator');
            end;
        end;
    end;


    [ServiceEnabled]
    procedure FnSubmitAcademicQualifications(entryNo: Integer; applicantNumber: Text; educationlevel: Integer; institutionname: Text; country: Text; qualificationtitle: Text; specializationarea: Text; attainedscore: Integer; fieldofstudy: Text; startdate: Date; enddate: Date) RetV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not SubmitAcademicQualifications(entryNo, applicantNumber, educationlevel, institutionname, country, qualificationtitle, specializationarea, attainedscore, fieldofstudy, startdate, enddate) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RetV);
    end;

    [TryFunction]
    procedure SubmitAcademicQualifications(entryNo: Integer; applicantNumber: Text; educationlevel: Integer; institutionname: Text; country: Text; qualificationtitle: Text; specializationarea: Text; attainedscore: Integer; fieldofstudy: Text; startdate: Date; enddate: Date)
    var

        JobApplicantsQualification: Record "Applicant Job Education2";
        LineNo: Integer;
    begin
        JobApplicantsQualification.Reset;
        JobApplicantsQualification.SetRange("Line No.", entryNo);
        JobApplicantsQualification.SetRange("Applicant No.", applicantNumber);
        if JobApplicantsQualification.FindSet then begin
            JobApplicantsQualification."Applicant No." := applicantNumber;
            JobApplicantsQualification."Education Level" := educationlevel;
            JobApplicantsQualification.Country := country;
            JobApplicantsQualification."Field of Study" := fieldofstudy;
            JobApplicantsQualification."Qualification Code" := qualificationtitle;
            JobApplicantsQualification.Validate("Qualification Code");
            JobApplicantsQualification."Institution Name" := institutionname;
            JobApplicantsQualification."Start Date" := startdate;
            JobApplicantsQualification."End Date" := enddate;
            JobApplicantsQualification.Description := specializationarea;
            if JobApplicantsQualification.Modify(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('Message', 'Details Successfully Updated');
                JsObject.Add('ApplicationNo', JobApplicantsQualification."Applicant No.");
            end else begin
                Error('Oops! Details Could not be Submitted');
            end;
        end else begin
            JobApplicantsQualification.Reset();
            JobApplicantsQualification.SetRange("Applicant No.", applicantNumber);
            if JobApplicantsQualification.FindLast() then
                LineNo := JobApplicantsQualification."Line No." + 10000
            else
                LineNo := 10000;

            JobApplicantsQualification.Init();
            JobApplicantsQualification."Applicant No." := applicantNumber;
            JobApplicantsQualification."Education Level" := educationlevel;
            JobApplicantsQualification.Country := country;
            JobApplicantsQualification."Field of Study" := fieldofstudy;
            JobApplicantsQualification."Qualification Code" := qualificationtitle;
            JobApplicantsQualification."Qualification Name" := specializationarea;
            JobApplicantsQualification."Score" := attainedscore;
            JobApplicantsQualification."Institution Name" := institutionname;
            JobApplicantsQualification."Start Date" := startdate;
            JobApplicantsQualification."End Date" := enddate;
            JobApplicantsQualification.Description := qualificationtitle;
            if JobApplicantsQualification.Insert(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('Message', 'Details Successfully submitted');
                JsObject.Add('ApplicationNo', JobApplicantsQualification."Applicant No.");
            end else begin
                Error('Oops! Details Could not be Submitted');
            end;
        end;

    end;

    [ServiceEnabled]
    procedure FnSubmitProffessionalQualifications(entryNo: Integer; applicantNumber: Text; qualificationtitle: Text; specializationarea: Text) RetV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not SubmitProffessionalQualifications(entryNo, applicantNumber, qualificationtitle, specializationarea) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RetV);
    end;

    [TryFunction]
    procedure SubmitProffessionalQualifications(entryNo: Integer; applicantNumber: Text; qualificationtitle: Text; specializationarea: Text)
    var
        JobApplicantsQualification: Record "Applicant Job Education2";
        LineNo: Integer;
    begin
        JobApplicantsQualification.Reset;
        JobApplicantsQualification.SetRange("Line No.", entryNo);
        JobApplicantsQualification.SetRange("Applicant No.", applicantNumber);
        if JobApplicantsQualification.FindSet then begin
            JobApplicantsQualification."Applicant No." := applicantNumber;
            JobApplicantsQualification."Education Type" := JobApplicantsQualification."Education Type"::Professional;
            JobApplicantsQualification."Qualification Code" := qualificationtitle;
            JobApplicantsQualification."Qualification Name" := specializationarea;
            JobApplicantsQualification.Description := qualificationtitle;
            if JobApplicantsQualification.Modify(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('Message', 'Details Successfully Updated');
                JsObject.Add('ApplicationNo', JobApplicantsQualification."Applicant No.");
            end else begin
                Error('Oops! Details Could not be Submitted');
            end;
        end else begin
            JobApplicantsQualification.Reset();
            JobApplicantsQualification.SetRange("Applicant No.", applicantNumber);
            if JobApplicantsQualification.FindLast() then
                LineNo := JobApplicantsQualification."Line No." + 10000
            else
                LineNo := 10000;

            JobApplicantsQualification.Init();
            JobApplicantsQualification."Applicant No." := applicantNumber;
            JobApplicantsQualification."Line No." := LineNo;
            JobApplicantsQualification."Education Type" := JobApplicantsQualification."Education Type"::Professional;
            JobApplicantsQualification."Qualification Code" := qualificationtitle;
            JobApplicantsQualification."Qualification Name" := specializationarea;
            JobApplicantsQualification.Description := qualificationtitle;
            if JobApplicantsQualification.Insert(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('Message', 'Details Successfully Updated');
                JsObject.Add('ApplicationNo', JobApplicantsQualification."Applicant No.");
            end else begin
                Error('Oops! Details Could not be Submitted');
            end;
        end;

    end;

    [ServiceEnabled]
    procedure FnSubmitProffessionaBodies(entryNo: Integer; applicantNumber: Text; professionalBody: Text; membershipNo: Text; yearAttained: Integer) RetV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not SubmitProffessionaBodies(entryNo, applicantNumber, professionalBody, membershipNo, yearAttained) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RetV);
    end;

    [TryFunction]

    procedure SubmitProffessionaBodies(entryNo: Integer; applicantNumber: Text; professionalBody: Text; membershipNo: Text; yearAttained: Integer)
    var
        ProffessionaBodies: Record "Applicant Prof Membership2";
        LineNo: Integer;
    begin
        ProffessionaBodies.Reset;
        ProffessionaBodies.SetRange("Line No.", entryNo);
        ProffessionaBodies.SetRange("Applicant No.", applicantNumber);
        if ProffessionaBodies.FindSet then begin
            ProffessionaBodies."Applicant No." := applicantNumber;
            ProffessionaBodies."Professional Body" := professionalbody;
            ProffessionaBodies.Validate("Professional Body");
            ProffessionaBodies."MembershipNo" := membershipNo;
            ProffessionaBodies."Year of Attainment" := yearAttained;
            if ProffessionaBodies.Modify(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('Message', 'Details Successfully Updated');
                JsObject.Add('ApplicationNo', ProffessionaBodies."Applicant No.");
            end else begin
                Error('Oops! Details Could not be Submitted');
            end;
        end else begin
            ProffessionaBodies.Reset();
            ProffessionaBodies.SetRange("Applicant No.", applicantNumber);
            if ProffessionaBodies.FindLast() then
                LineNo := ProffessionaBodies."Line No." + 10000
            else
                LineNo := 10000;

            ProffessionaBodies.Init();
            ProffessionaBodies."Applicant No." := applicantNumber;
            ProffessionaBodies."Line No." := LineNo;
            ProffessionaBodies."Professional Body" := professionalbody;
            ProffessionaBodies.Validate("Professional Body");
            ProffessionaBodies."MembershipNo" := membershipNo;
            ProffessionaBodies."Year of Attainment" := yearAttained;
            if ProffessionaBodies.Insert(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('Message', 'Details Successfully Submit');
                JsObject.Add('ApplicationNo', ProffessionaBodies."Applicant No.");
            end else begin
                Error('Oops! Details Could not be Submitted');
            end;

        end;


    end;

    [ServiceEnabled]
    procedure FnSubmitWorkExperience(entryNo: Integer; applicantNumber: Text; employerName: Text; jobdesignation: Text; employmentstartdate: Date; employmentenddate: Date; hierachyLevel: Integer; dutiesresponsibilities: Text; industry: Text; currentEmployer: Boolean) RetV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not SubmitWorkExperience(entryNo, applicantNumber, employerName, jobdesignation, employmentstartdate, employmentenddate, hierachyLevel, dutiesresponsibilities, industry, currentEmployer) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RetV);
    end;

    [TryFunction]
    procedure SubmitWorkExperience(entryNo: Integer; applicantNumber: Text; employerName: Text; jobdesignation: Text; employmentstartdate: Date; employmentenddate: Date; hierachyLevel: Integer; dutiesresponsibilities: Text; industry: Text; currentEmployer: Boolean)
    var
        ApplicantsExperience: Record "Applicant Job Experience2";
        LineNo: Integer;
    begin
        ApplicantsExperience.Reset;
        ApplicantsExperience.SetRange("Line No", entryNo);
        ApplicantsExperience.SetRange("Applicant No.", applicantNumber);
        if ApplicantsExperience.FindSet then begin
            ApplicantsExperience."Applicant No." := applicantNumber;
            ApplicantsExperience."Job Title" := jobdesignation;
            ApplicantsExperience.Employer := employerName;
            ApplicantsExperience."Start Date" := employmentstartdate;
            ApplicantsExperience."End Date" := employmentenddate;
            ApplicantsExperience.Description := dutiesresponsibilities;
            ApplicantsExperience."Hierarchy Level" := hierachyLevel;
            ApplicantsExperience.Industry := industry;
            ApplicantsExperience."Current employment" := currentEmployer;
            ApplicantsExperience."Present Employment" := currentEmployer;
            if ApplicantsExperience.Modify(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('Message', 'Details Successfully Updated');
                JsObject.Add('ApplicationNo', ApplicantsExperience."Applicant No.");
            end else begin
                Error('Oops! Details Could not be Submitted');
            end;
        end else begin
            ApplicantsExperience.Reset();
            ApplicantsExperience.SetRange("Applicant No.", applicantNumber);
            if ApplicantsExperience.FindLast() then
                LineNo := ApplicantsExperience."Line No" + 10000
            else
                LineNo := 10000;

            ApplicantsExperience.Init();
            ApplicantsExperience."Applicant No." := applicantNumber;
            ApplicantsExperience."Line No" := LineNo;
            ApplicantsExperience."Job Title" := jobdesignation;
            ApplicantsExperience.Employer := employerName;
            ApplicantsExperience."Start Date" := employmentstartdate;
            ApplicantsExperience."End Date" := employmentenddate;
            ApplicantsExperience.Description := dutiesresponsibilities;
            ApplicantsExperience."Hierarchy Level" := hierachyLevel;
            ApplicantsExperience.Industry := industry;
            ApplicantsExperience."Current employment" := currentEmployer;
            ApplicantsExperience."Present Employment" := currentEmployer;
            if ApplicantsExperience.Insert(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('Message', 'Details Successfully Submitted');
                JsObject.Add('ApplicationNo', ApplicantsExperience."Applicant No.");
            end else begin
                Error('Oops! Details Could not be Submitted');
            end;
        end;

    end;

    [ServiceEnabled]
    procedure FnSubmitCandidateReferees(entryNo: Integer; applicantNumber: Text; fullName: Text; contactdesignations: Text; emailaddress: Text; phonenumber: Text; address: Text; institution: Text) RetV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not SubmitCandidateReferees(entryNo, applicantNumber, fullName, contactdesignations, emailaddress, phonenumber, address, institution) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RetV);
    end;

    [TryFunction]
    procedure SubmitCandidateReferees(entryNo: Integer; applicantNumber: Text; fullName: Text; contactdesignations: Text; emailaddress: Text; phonenumber: Text; address: Text; institution: Text)
    var
        ApplicantReferees: Record "Applicant Referees2";
        LineNo: Integer;
    begin
        ApplicantReferees.Reset();
        ApplicantReferees.SetRange("No", applicantNumber);
        ApplicantReferees.SetRange("Line No.", entryNo);
        if ApplicantReferees.FindSet(true) then begin
            ApplicantReferees."No" := applicantNumber;
            ApplicantReferees.Names := fullName;
            ApplicantReferees."Designation" := contactdesignations;
            ApplicantReferees.Company := institution;
            ApplicantReferees."Telephone No" := phonenumber;
            ApplicantReferees."E-Mail" := emailaddress;
            ApplicantReferees.Address := address;
            if ApplicantReferees.Modify(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('Message', 'Details Successfully Updated');
                JsObject.Add('ApplicationNo', ApplicantReferees."No");
            end else begin
                Error('Oops! Details Could not be Submitted');
            end;
        end else begin
            ApplicantReferees.Reset();
            ApplicantReferees.SetRange("No", applicantNumber);
            if ApplicantReferees.FindLast() then
                LineNo := ApplicantReferees."Line No." + 10000
            else
                LineNo := 10000;
            ApplicantReferees.Init();
            ApplicantReferees."Line No." := LineNo;
            ApplicantReferees."No" := applicantNumber;
            ApplicantReferees.Names := fullName;
            ApplicantReferees."Designation" := contactdesignations;
            ApplicantReferees.Company := institution;
            ApplicantReferees."Telephone No" := phonenumber;
            ApplicantReferees."E-Mail" := emailaddress;
            ApplicantReferees.Address := address;
            if ApplicantReferees.Insert(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('Message', 'Details Successfully Submitted');
                JsObject.Add('ApplicationNo', ApplicantReferees."No");
            end else begin
                Error('Message', 'Details Could not be Submitted');
            end;
        end;

    end;

    [ServiceEnabled]
    procedure FnCreateJobApplication(applicantNumber: Text; vacancyId: Text) RetV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not CreateJobApplication(applicantNumber, vacancyId) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RetV);
    end;

    [TryFunction]

    procedure CreateJobApplication(applicantNumber: Text; vacancyId: Text)
    var
        JobApplications: Record "Applicant job applied";
        Applicant: Record Applicants2;
    begin
        Applicant.Reset;
        Applicant.SetRange("No.", applicantNumber);
        // Applicant.SetRange("Profile Completed", true);
        if Applicant.FindSet then begin
            JobApplications.Reset;
            JobApplications.SetRange("Need Code", VacancyId);
            JobApplications.SetRange("Application No.", applicantNumber);
            if JobApplications.FindSet then begin
                JobApplications."Application No." := applicantNumber;
                JobApplications.Validate("Application No.");
                JobApplications."Need Code" := VacancyId;
                JobApplications.Validate("Need Code");
                if JobApplications.Modify(true) then begin
                    //FnSubmitApplication                 
                    JsObject.Add('Error', 'FALSE');
                    JsObject.Add('Message', 'Job Application Process was Successfully Submitted');
                    JsObject.Add('ApplicationNo', JobApplications."No.");
                end else begin
                    Error('Message', 'Job Application Process was not successfull');
                end;
            end else begin
                JobApplications.Init;
                JobApplications."No." := '';
                JobApplications."Application No." := applicantNumber;
                JobApplications.Validate("Application No.");
                JobApplications."Need Code" := VacancyId;
                JobApplications.Validate("Need Code");
                if JobApplications.Insert(true) then begin
                    //FnSubmitApplication
                    JsObject.Add('Error', 'FALSE');
                    JsObject.Add('Message', 'Job Application Process was Successfully Submitted');
                    JsObject.Add('ApplicationNo', JobApplications."No.");
                end else begin
                    Error('Message', 'Job Application Process was not successfully');
                end;
            end;
        end else begin

            Error('profileincomplete', 'Candidate profile was not successfully completed');
        end;
    end;


    procedure FnSubmitApplication(ApplicantNumber: Code[100]; JobAppplicationNumber: Code[100]) status: Text
    var
        ApplicantProfile: Record Contact;
        Contact: Record Contact;
        NoSeriesManagement: Codeunit NoSeriesManagement;
        MarketingSetup: Record "Marketing Setup";
    // JobApplicantsQualification: Record "Job Applicants Qualification";
    // JobApplications: Record "Job Applications";
    begin
        /* JobApplications.Reset;
         JobApplications.SetRange("Application No.", JobAppplicationNumber);
         JobApplications.SetRange("Candidate No.", ApplicantNumber);
         if JobApplications.FindSet then begin
             JobApplications.Validate("Candidate No.");

             FileDirectory := 'C:\DOCS\';
             FileName := 'JobApplication_' + JobAppplicationNumber + '.pdf';
             //Report.SaveAsPdf(69608, FileDirectory + FileName, JobApplications);
             SMTPMailSetup.Get;
             Email2 := SMTPMailSetup."Email Address";
             Body := 'JOB VACANCY APPLICATION';
             //     SMTP.CreateMessage('JOB VACANCY APPLICATION', Email2, JobApplications."E-Mail",
             //    'JOB VACANCY APPLICATION',
             //    'Dear ' + JobApplications."First Name" + '<br>' + JobApplications."Last Name" + ',<br><br>' +
             //    'We are pleased to inform you that your application for the post<b>' + ' ' + JobApplications."Job Title/Designation" + '</b> has been Received Successfully.' + ',<br><br>' + ' Your Job Application Number is' + '<BR><b>' + JobAppplicationNumber + '<br>' + '</b>' +
             //    'You will be contacted shortly and an email sent to you as regards when you will be invited for your interview<br>' +
             //    'Use the following link to acess the E-Recruitment Portal.' + ' ' + '<b><a href="http://192.168.1.87:7988/">E-Recruitment Portal</a></b><br>'
             //    + '<br>'
             //    , true);
             //     SMTP.AddAttachment(FileDirectory + FileName, FileName);
             //     SMTP.AddBodyline('<br><br>Kind Regards,' + '<br><br>Human Resource <br><br>[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]<br>');
             //     SMTP.Send();
             status := 'success*The Job Application has been Received Successfully';
         end else begin
             status := 'danger*The Job Application was not sent Successfully';
         end;
         */

    end;

    procedure FnSubmitProfileApplication(ApplicantNumber: Code[100]) status: Text
    var
    // JobApplicantsQualification: Record "Job Applicants Qualification";
    // JobApplications: Record "Job Applications";
    // Applicant: Record Applicant;
    begin

        //<<< New Changes
        /*
                Applicant.Reset;
                Applicant.SetRange("Candidate No.", ApplicantNumber);
                if Applicant.FindSet then begin
                    Applicant."Profile Completed" := true;
                    Applicant.Modify(true);
                    FileDirectory := 'C:\DOCS\';
                    FileName := 'CandidateCV' + ApplicantNumber + '.pdf';
                    //     Report.SaveAsPdf(Report::"Applicant CV", FileDirectory + FileName, Applicant);
                    //     SMTPMailSetup.Get;
                    //     Email2 := SMTPMailSetup."Email Address";
                    //     Body := 'CANDIDATE RESUME';

                    //     SMTP.CreateMessage('CANDIDATE RESUME', Email2, Applicant."E-Mail",
                    //     'CANDIDATE RESUME',
                    //     'Dear ' + Applicant."First Name" + ',<br><br>' +
                    //     'We are pleased to inform you that your profile has been received Successfully <b>' + '</b><br>' +
                    //     'Use the following link to acess the E-Recruitment Portal.' + ' ' + '<b><a href="http://192.168.1.87:7988/">E-Recruitment Portal</a></b><br>'
                    //     + '<br>'
                    //     , true
                    //  );

                    //     SMTP.AddAttachment(FileDirectory + FileName, FileName);
                    //     SMTP.AddBodyline('<br><br>Kind Regards,' + '<br><br>Human Resource <br><br>[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]<br>');
                    //     SMTP.Send();
                    status := 'success*The Candidate Profile has been Received Successfully';
                end else begin
                    status := 'danger*The Candidate Profile has been Received Successfully';
                end;
        */
    end;

    procedure FnSendEmaiNotificationOnApplicantAccountActivation(ApplicantRequest: Record Applicants2)
    var
        SupplierReq: Record Contact;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        FileDirectory: Text[100];
        FileName: Text[100];
        ReportID: Integer;
        Window: Dialog;
        RunOnceFile: Text[1000];
        TimeOut: Integer;
        EmailBody: array[2] of Text[30];
        BodyText: Text[250];
        mymail: Codeunit Mail;
        DefaultPrinter: Text[200];
        WindowisOpen: Boolean;
        FileDialog: Codeunit Mail;
        SendingDate: Date;
        SendingTime: Time;
        Counter: Integer;
        SMTPMail_CU: Codeunit Mail;
        SenderAddress: Text[100];
        CustEmail: Text[100];
        HRSetupNew: Record "Human Resources Setup";
        HRSetup: Record "Company Information";
        CompInfo: Record "Company Information";
        IsEmailValid: Boolean;
        RequesterName: Text[100];
        RequesterEmail: Text[100];
        emailhdr: Text[100];
        CompanyDetails: Text[250];
        SupplierDetails: Text[1000];
        SenderMessage: Text[1000];
        ProcNote: Text[1000];
        LoginDetails: Text[1000];
        PortalUser: Record "Portal User";
        Password: Text[50];
        ActivationDetails: Text[1000];
        Email: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
        EmailScenario: enum "Email Scenario";
    begin

        CompInfo.Get;

        RequesterEmail := ApplicantRequest."E-Mail";
        RequesterName := OnlineApplicants."First Name" + ' ' + OnlineApplicants."Middle Name" + ' ' + OnlineApplicants."Last Name";

        Counter := Counter + 1;
        // PortalUser.Reset;
        // PortalUser.SetRange("Authentication Email", ApplicantRequest."E-Mail");
        // if PortalUser.FindSet then Password := PortalUser."Password Value";
        Password := ApplicantRequest.Password;

        CompanyDetails := 'Dear ' + RequesterName + ',' + '<br>';

        SenderMessage := 'Please note that your applicant account has been created on our system with the following key registration details:<br> <br>';

        SupplierDetails := '<br> Registration Request Reference No: ' + ApplicantRequest."No." +
                          '<br> Name: ' + RequesterName +
                          '<br> Mobile Phone No: ' + ApplicantRequest."Home Phone Number";

        LoginDetails := '<br> We have also created your portal access account with the following login credentials:' +
                          '<br>  User Name :' + ApplicantRequest."E-Mail" +
                          '<br> <b> Password :' + Password + '</b>' +
                          '<br> <br>To access our portal and complete your registration click on the link below to access the ' +
                          'GBA E-Recruitment Portal and complete your Profile';

        ActivationDetails := '<br> Once you access our portal, you shall be able to complete the Confidential Applicant section ' +
                                 'of the registration that shall require you to provide the following information: </br>' +
                            '<br> 1. Personal Information' +
                            '<br> 2. Contact details' +
                            '<br> 3. Academic Qualifications' +
                            '<br> 4. Proffessional Qualifications' +
                            '<br> 5. Employment History' +
                            '<br> 6. Referees' +
                            '<br> 7. Qualification Attachments' +
                            '<br> <br><a href="#">E-Recruitment Portal Link</a></br>';
        if RequesterEmail = '' then exit;

        emailhdr := 'GBA e-Recruitment Account Activation - [' + ApplicantRequest."No." + '])';

        EmailMsg.Create(RequesterEmail, emailhdr, CompanyDetails + '<br></br>' + SenderMessage + SupplierDetails + LoginDetails + ActivationDetails, true);
        Email.Send(EmailMsg, EmailScenario::Default);

        SendingDate := Today;
        SendingTime := Time;

        Sleep(1000);

        //Window.CLOSE;

    end;

    [ServiceEnabled]
    procedure FnDeleteAacademicDetails(entryNo: Integer; candidateNumber: Code[100]) RetV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not DeleteAacademicDetails(entryNo, candidateNumber) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RetV);
    end;

    [TryFunction]
    procedure DeleteAacademicDetails(entryNo: Integer; candidateNumber: Code[100])
    var
        JobApplicantsQualification: Record "Applicant Job Education2";
    begin

        JobApplicantsQualification.Reset;
        JobApplicantsQualification.SetRange("Applicant No.", candidateNumber);
        JobApplicantsQualification.SetRange("Line No.", entryNo);
        if JobApplicantsQualification.FindSet then begin
            if JobApplicantsQualification.Delete(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('Message', 'Your Academic Details was successfully Deleted');
                JsObject.Add('ApplicationNo', JobApplicantsQualification."Applicant No.");
            end else begin
                Error('Your Academic Details was not successfully Delete');
            end;
        end;

    end;

    [ServiceEnabled]
    procedure FnDeleteJobAcademicDetails(entryNo: Integer; candidateNumber: Code[100]) RetV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not DeleteJobAcademicDetails(entryNo, candidateNumber) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RetV);
    end;

    [TryFunction]
    procedure DeleteJobAcademicDetails(entryNo: Integer; candidateNumber: Code[100])
    var
        ApplicationQualification: Record "Applicant Job Education2";
    begin
        ApplicationQualification.Reset;
        ApplicationQualification.SetRange("Applicant No.", candidateNumber);
        ApplicationQualification.SetRange("Line No.", entryNo);
        if ApplicationQualification.FindSet then begin
            if ApplicationQualification.Delete(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('Message', 'Your Academic Details was successfully Deleted');
                JsObject.Add('ApplicationNo', ApplicationQualification."Applicant No.");
            end else begin
                Error('Your Academic Details was not successfully Delete');
            end;
        end;

    end;

    [ServiceEnabled]
    procedure FnDeleteProffessionalQualificationDetails(entryNo: Integer; candidateNumber: Code[100]) RetV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not DeleteProffessionalQualificationDetails(entryNo, candidateNumber) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RetV);
    end;

    [TryFunction]
    procedure DeleteProffessionalQualificationDetails(entryNo: Integer; candidateNumber: Code[100])
    var
        JobApplicantsQualification: Record "Applicant Job Education2";
    begin

        JobApplicantsQualification.Reset;
        JobApplicantsQualification.SetRange("Applicant No.", candidateNumber);
        JobApplicantsQualification.SetRange("Line No.", entryNo);
        if JobApplicantsQualification.FindSet then begin
            if JobApplicantsQualification.Delete(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('Message', 'Your Proffesional Bodies Details was successfully Deleted');
                JsObject.Add('ApplicationNo', JobApplicantsQualification."Applicant No.");
            end else begin
                Error('Your Proffesional Bodies Details was not successfully Delete');
            end;
        end;

    end;

    [ServiceEnabled]
    procedure FnDeleteProffessionalQualificationBodiesDetails(entryNo: Integer; candidateNumber: Code[100]) RetV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not DeleteProffessionalQualificationBodiesDetails(entryNo, candidateNumber) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RetV);
    end;

    [TryFunction]
    procedure DeleteProffessionalQualificationBodiesDetails(entryNo: Integer; candidateNumber: Code[100])
    var
        ProffessionaBodies: Record "Applicant Prof Membership2";
    begin

        ProffessionaBodies.Reset;
        ProffessionaBodies.SetRange("Applicant No.", candidateNumber);
        ProffessionaBodies.SetRange("Line No.", entryNo);
        if ProffessionaBodies.FindSet then begin
            if ProffessionaBodies.Delete(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('Message', 'Your Proffesional Bodies Details was successfully Deleted');
                JsObject.Add('ApplicationNo', ProffessionaBodies."Applicant No.");
            end else begin
                Error('Your Proffesional Bodies Details was not successfully Delete');
            end;
        end;

    end;

    [ServiceEnabled]
    procedure FnDeleteWorkExperienceDetails(entryNo: Integer; candidateNumber: Code[100]) RetV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not DeleteWorkExperienceDetails(entryNo, candidateNumber) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RetV);
    end;

    [TryFunction]
    procedure DeleteWorkExperienceDetails(entryNo: Integer; candidateNumber: Code[100])
    var
        ApplicantsExperience: Record "Applicant Job Experience2";
    begin

        ApplicantsExperience.Reset;
        ApplicantsExperience.SetRange("Applicant No.", candidateNumber);
        ApplicantsExperience.SetRange("Line No", entryNo);
        if ApplicantsExperience.FindSet then begin
            if ApplicantsExperience.Delete(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('Message', 'Your Work Experience Details was successfully Deleted');
                JsObject.Add('ApplicationNo', ApplicantsExperience."Applicant No.");
            end else begin
                Error('Your Work Experience Details was not successfully Delete');
            end;
        end;

    end;

    [ServiceEnabled]
    procedure FnDeleteRefereeDetails(entryNo: Integer; candidateNumber: Code[100]) RetV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not DeleteRefereeDetails(entryNo, candidateNumber) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RetV);
    end;

    [TryFunction]
    procedure DeleteRefereeDetails(entryNo: Integer; candidateNumber: Code[100])
    var
        EmployeeApplicantReferees: Record "Applicant Referees2";
    begin

        EmployeeApplicantReferees.Reset;
        EmployeeApplicantReferees.SetRange("No", candidateNumber);
        EmployeeApplicantReferees.SetRange("Line No.", entryNo);
        if EmployeeApplicantReferees.FindSet then begin
            if EmployeeApplicantReferees.Delete(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('Message', 'Your Referee Details was successfully Deleted');
                JsObject.Add('ApplicationNo', EmployeeApplicantReferees."No");
            end else begin
                Error('Your Referee Details was not successfully Delete');
            end;
        end;

    end;

    [ServiceEnabled]
    procedure FnDeleteJobProffesionalQualificationDetails(entryNo: Integer; candidateNumber: Code[100]) RetV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not DeleteJobProffesionalQualificationDetails(entryNo, candidateNumber) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RetV);
    end;

    [TryFunction]
    procedure DeleteJobProffesionalQualificationDetails(entryNo: Integer; candidateNumber: Code[100])
    var
        ApplicationQualification: Record "Applicant Job Education2";
    begin
        ApplicationQualification.Reset;
        ApplicationQualification.SetRange("Applicant No.", candidateNumber);
        ApplicationQualification.SetRange("Line No.", entryNo);
        if ApplicationQualification.FindSet then begin
            if ApplicationQualification.Delete(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('Message', 'Your Proffesional Qulaifications Details was successfully Deleted');
                JsObject.Add('ApplicationNo', ApplicationQualification."Applicant No.");
            end else begin
                Error('Your Proffesional Qulaifications Details was not successfully Delete');
            end;
        end;

    end;

    [ServiceEnabled]
    procedure FnDeleteJobProffesionalBodiesDetails(entryNo: Integer; candidateNumber: Code[100]) RetV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not DeleteJobProffesionalBodiesDetails(entryNo, candidateNumber) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RetV);
    end;

    [TryFunction]
    procedure DeleteJobProffesionalBodiesDetails(entryNo: Integer; candidateNumber: Code[100])
    var
        ProffessionaBodies: Record "Applicant Prof Membership2";
    begin
        ProffessionaBodies.Reset;
        ProffessionaBodies.SetRange("Applicant No.", candidateNumber);
        ProffessionaBodies.SetRange("Line No.", entryNo);
        if ProffessionaBodies.FindSet then begin
            if ProffessionaBodies.Delete(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('Message', 'Your Proffesional Bodies Details was successfully Deleted');
                JsObject.Add('ApplicationNo', ProffessionaBodies."Applicant No.");
            end else begin
                Error('Your Proffesional Bodies Details was not successfully Delete');
            end;
        end;

    end;

    procedure FnCreateCandidateDocumentsLink(applicantNo: Code[50]; ApplicationNo: Code[50]; FileName: Text; FileLink: Text) status: Text
    var
        JobApplications: Record "Applicant job applied";
        DocumentAttachment: Record "Document Attachment";
        RecordLink: Record "Record Link";
    begin
        if RecordLink."Link ID" = 0 then begin
            RecordLink.URL1 := FileLink;
            RecordLink.Description := FileName;
            RecordLink.Type := RecordLink.Type::Link;
            RecordLink.Company := COMPANYNAME;
            RecordLink."User ID" := UserId;
            RecordLink.Created := CreateDatetime(Today, Time);
            JobApplications.Reset;
            JobApplications."Application No." := ApplicationNo;
            if JobApplications.Find('=') then
                RecordIDNumber := JobApplications.RecordId;
            RecordLink."Record ID" := RecordIDNumber;
            if RecordLink.Insert(true) then begin
                status := 'success*Link successfully created';
            end else begin
                status := 'error*An error occured during the process of creating link';
            end
        end;
    end;

    [ServiceEnabled]
    procedure FnDeleteJobApplicationRefereeDetails(entryNo: Integer; candidateNumber: Code[100]) RetV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not DeleteJobApplicationRefereeDetails(entryNo, candidateNumber) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RetV);
    end;

    [TryFunction]
    procedure DeleteJobApplicationRefereeDetails(entryNo: Integer; candidateNumber: Code[100])
    var
        ApplicationReferees: Record "Applicant Referees2";
    begin

        ApplicationReferees.Reset;
        ApplicationReferees.SetRange("No", candidateNumber);
        ApplicationReferees.SetRange("Line No.", entryNo);
        if ApplicationReferees.FindSet then begin
            if ApplicationReferees.Delete(true) then begin
                JsObject.Add('Error', 'FALSE');
                JsObject.Add('Message', 'Your Referee Details was successfully Deleted');
                JsObject.Add('ApplicationNo', ApplicationReferees."No");
            end else begin
                Error('Your Referee Details was not successfully Delete');
            end;
        end;

    end;

    [ServiceEnabled]
    procedure FnUploadAttachedDocument(docNo: Code[50]; fileName: Text; fileExt: Text; attachment: Text; tableID: Integer) returnV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not UploadAttachedDocument(docNo, fileName, fileExt, attachment, tableID) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(returnV);
    end;

    [TryFunction]
    procedure UploadAttachedDocument(DocNo: Code[50]; FileName: Text; fileExt: Text; attachment: Text; TableID: Integer)
    var
        FromRecRef: RecordRef;
        FileManagement: Codeunit "File Management";
        tableFound: Boolean;
        DocAttachment: Record "Document Attachment";
    begin
        tableFound := false;
        if TableID = Database::Applicants2 then begin
            OnlineApplicants.RESET;
            OnlineApplicants.SETRANGE("No.", DocNo);
            if OnlineApplicants.FIND('-') then begin
                FromRecRef.GETTABLE(OnlineApplicants);
            end;
            tableFound := true;
        end;

        if tableFound = true then begin
            if FileName <> '' then begin
                Clear(DocAttachment);
                TempBlob_lRec.CreateOutStream(OutStr, TEXTENCODING::UTF8);
                Base64Convert.FromBase64(attachment, Outstr);
                TempBlob_lRec.CreateInStream(InStr, TEXTENCODING::UTF8);

                DocAttachment.Init();
                DocAttachment.Validate("File Extension", fileExt);
                DocAttachment.Validate("File Name", FileName);
                DocAttachment.Validate("Table ID", FromRecRef.Number);
                DocAttachment.Validate("No.", DocNo);
                DocAttachment."Document Reference ID".ImportStream(InStr, '', FileName);
                DocAttachment.Insert(true);
                JsObject.Add('Error', 'FALSE');
            end else
                Error('No file to upload');
        end else
            Error('File not uploaded. No table filter found');
    end;

    [ServiceEnabled]
    procedure FnDeleteDocumentAttachment(docNo: Code[20]; tableID: Integer; docID: Integer) returnV: Text
    var
        DocAttachment: Record "Document Attachment";
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not DropDocumentAttachment(docNo, tableID, docID) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(returnV);
    end;

    [TryFunction]
    procedure DropDocumentAttachment(DocNo: Code[20]; TableID: Integer; DocID: Integer)
    var
        DocAttachment: Record "Document Attachment";
    begin
        DocAttachment.Reset();
        DocAttachment.SetRange("Table ID", TableID);
        DocAttachment.SetRange("No.", DocNo);
        DocAttachment.SetRange(ID, DocID);
        if DocAttachment.Find('-') then begin
            if DocAttachment."Document Reference ID".HasValue then begin
                Clear(DocAttachment."Document Reference ID");
                DocAttachment.Modify(true);
            end;
            DocAttachment.Delete(true);
            JsObject.Add('Error', 'FALSE');
        end;
    end;

    [ServiceEnabled]
    procedure FnGetDocumentAttachment(tableId: Integer; no: Code[20]; recID: Integer) BaseImage: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not GetAttachment(tableId, no, recID) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(BaseImage);
    end;

    [TryFunction]
    procedure GetAttachment(tableId: Integer; No: Code[20]; RecID: Integer)
    var
        TenantMedia: Record "Tenant Media";
        imageID: GUID;
        docAttachment: Record "Document Attachment";
        BaseImage: Text;
        fom: Codeunit "Format Document";
    begin
        docAttachment.Reset();
        docAttachment.SetRange("Table ID", tableId);
        docAttachment.SetRange("No.", No);
        docAttachment.SetRange(ID, RecID);
        if docAttachment.find('-') then begin
            if docAttachment."Document Reference ID".Hasvalue then begin
                imageID := docAttachment."Document Reference ID".MediaId;
                IF TenantMedia.GET(imageID) THEN BEGIN
                    TenantMedia.CALCFIELDS(Content);
                    TenantMedia.Content.CreateInstream(InStr, TEXTENCODING::UTF8);
                    BaseImage := Base64Convert.ToBase64(InStr);
                    JsObject.Add('Error', 'FALSE');
                    JsObject.Add('BaseImage', BaseImage);
                END;
            end;
        end;
    end;


    procedure FnGenerateVacancyAdvert(VcancyNo: Code[20]) status: Text
    var
        VacancyAdvert: Record "Recruitment Needs";
    begin

        VacancyAdvert.Reset;
        VacancyAdvert.SetRange("No.", VcancyNo);

        if VacancyAdvert.FindSet then begin
            // if FILE.Exists(FILEPATH + VcancyNo + '.pdf') then
            //     FILE.Erase(FILEPATH + VcancyNo + '.pdf');
            // Report.SaveAsPdf(69605, FILEPATH + VcancyNo + '.pdf', VacancyAdvert);
            status := 'success*Generated*Files\' + VcancyNo + '.pdf';

        end else begin
            status := 'danger*The Report Could not be generated';
        end
    end;

    procedure FnGenerateJobApplicantReport(CandidateNo: Code[20]; JobApplicantNumber: Code[20]) status: Text
    var
        JobApplications: Record "Applicant job applied";
    begin
        JobApplications.Reset;
        JobApplications.SetRange("Application No.", JobApplicantNumber);
        // JobApplications.SetRange("Candidate No.", CandidateNo);
        if JobApplications.FindSet then begin
            // if FILE.Exists(FILESPATH2 + JobApplicantNumber + '.pdf') then
            //     FILE.Erase(FILESPATH2 + JobApplicantNumber + '.pdf');
            // Report.SaveAsPdf(69608, FILESPATH2 + JobApplicantNumber + '.pdf', JobApplications);
            status := 'success*Generated*Downloads\JobApplicants\' + JobApplicantNumber + '.pdf';

        end else begin
            status := 'danger*The Report Could not be generated';
        end
    end;

    procedure FnCreateApplicantDocumentsLink(applicantNo: Code[50]; FileName: Text; FileLink: Text) status: Text
    var
        Applicant: Record Applicants2;
        DocumentAttachment: Record "Document Attachment";
        RecordLink: Record "Record Link";
    begin
        // Record Links Attachment on the Applications -Obadiah Korir
        if RecordLink."Link ID" = 0 then begin
            RecordLink.URL1 := FileLink;
            RecordLink.Description := FileName;
            RecordLink.Type := RecordLink.Type::Link;
            RecordLink.Company := COMPANYNAME;
            RecordLink."User ID" := UserId;
            RecordLink.Created := CreateDatetime(Today, Time);
            Applicant.Reset;
            Applicant."No." := applicantNo;
            if Applicant.Find('=') then
                RecordIDNumber := Applicant.RecordId;
            RecordLink."Record ID" := RecordIDNumber;
            if RecordLink.Insert(true) then begin
                status := 'success*Link successfully created';
            end else begin
                status := 'error*An error occured during the process of creating link';
            end
        end;
    end;


    var
        PortalUser: Record "Portal User";
        JsObject: JsonObject;
        ApplicationEntryNumber: Integer;
        OnlineApplicants: Record Applicants2;
        SMTPMailSetup: Record "Email Account";
        Email2: Text;
        Body: Text;
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        FileDirectory: Text;
        FileName: Text;
        SMTP: Codeunit Mail;
        RecordIDNumber: RecordID;
        Contact_Test: Record Contact;
        TempBlob_lRec: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
        RecRef: RecordRef;
        FileManagement_lCdu: Codeunit "File Management";
        Base64Convert: Codeunit "Base64 Convert";
        FILEPATH3: label 'C:\inetpub\wwwroot\Recruitment140421\Files\';
        FILESPATH4: label 'C:\inetpub\wwwroot\Recruitment140421\Downloads\JobApplicants\';
        FILESPATH2: label '//192.168.1.181\eRecruitent\Downloads\JobApplicants\';
        FILEPATH: label '//192.168.1.181\eRecruitent\Files\';
}

